import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import SProcess 1.0

Page {

    property Menu menu: Menu {
        title: qsTr("Ping actions")
        MenuItem {
            text: qsTr("Add device ...")
            onClicked: addDeviceDialog.open()
        }
        MenuItem {
            id: menuDeleteAction
            text: qsTr("Delete")
            checkable: true
            enabled: pingModel.count > 0
        }
    }

    title: qsTr("Ping")

    ListModel {
        id: pingModel
    }

    Settings {
        category: "PingModel"
        property string dataModel: "[]"
        Component.onCompleted: {
            var obj = JSON.parse(dataModel);
            for(var item in obj) {
                pingModel.append({"hostname":obj[item].hostname,"username":obj[item].username});
            }
        }
        Component.onDestruction: {
            var obj = [];
            var count = pingModel.count;
            for(var i = 0; i < count; i ++) {
                var item = pingModel.get(i);
                obj.push({"hostname":item.hostname,"username":item.username});
            }
            dataModel = JSON.stringify(obj);
        }
    }

    ListView {
        id:listView
        anchors.fill: parent
        model: pingModel
        delegate: PingDelegate {
            id: pingDelegate
            width: parent.width
            hostname: model.hostname
            username: model.username

            swipe.right: Button {
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height
                visible: swipe.complete
                text: qsTr("Delete")
                onClicked: {
                    swipe.close();
                    pingModel.remove(index);
                }
                highlighted: true
            }

            onClicked: {
                ListView.view.currentIndex = index;
                if(menuDeleteAction.checked) {
                    pingDelegate.swipe.open(SwipeDelegate.Right)
                }
            }

            ListView.onCurrentItemChanged: if(!ListView.isCurrentItem && pingDelegate.swipe.complete) pingDelegate.swipe.close()

        }
        displaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 500 }
        }
        ScrollBar.vertical: ScrollBar {}
    }

    Dialog {
        id: addDeviceDialog
        x: Math.round((window.width - width) / 2)
        y: Math.round(window.height / 6)
        width: Math.round(Math.min(window.width, window.height) / 3 * 2)
        title: qsTr("Add device")
        modal: true
        standardButtons: Dialog.Ok | Dialog.Cancel

        ColumnLayout {
            spacing: 20
            anchors.fill: parent
            TextField {
                id: addDeviceDialogHostname
                focus: true
                placeholderText: qsTr("Hostname or IP address")
                Layout.fillWidth: true
            }
            TextField {
                id: addDeviceDialogUsername
                placeholderText: qsTr("Short description")
                Layout.fillWidth: true
            }
        }

        onAccepted: {
            var hostname = addDeviceDialogHostname.text.trim();
            var username = addDeviceDialogUsername.text.trim();
            if(hostname.length > 0)
                pingModel.append({"hostname":hostname,"username":username});
            addDeviceDialogHostname.clear();
            addDeviceDialogUsername.clear();
        }
    }

    footer: Button {
        id: deleteHintButton
        anchors.left: parent.left
        anchors.right: parent.right
        text: qsTr("Click item to delete")
        visible: menuDeleteAction.checked
        onClicked: { menuDeleteAction.checked = false; listView.currentIndex = -1}
        states: State {
            when: deleteHintButton.hovered
            PropertyChanges {
                target: deleteHintButton
                text: qsTr("Done")
            }
        }
    }
}

