import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import SProcess 1.0

Page {

    property Menu menu: Menu {
        title: qsTr("Ping actions")
        MenuItem {
            text: qsTr("Add device ...")
            onClicked: addDeviceDialog.open()
        }
        MenuItem {
            text: "Second"
        }
    }

    title: qsTr("Ping")

    ListModel {
        id: pingModel
        ListElement {
            hostname: "google.com"
            username: "Google"
        }
        ListElement {
            hostname: "ya.ru"
            username: "Yandex"
        }
        ListElement {
            hostname: "yahoo.com"
            username: "yahoo"
        }
        ListElement {
            hostname: "wikipedia.org"
            username: "wiki"
        }
        ListElement {
            hostname: "pikabu.ru"
            username: "pikabu"
        }
        ListElement {
            hostname: "error"
            username: "error"
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

            onClicked: { ListView.view.currentIndex = index; }

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
}

