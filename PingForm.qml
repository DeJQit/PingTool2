import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import SProcess 1.0

Page {

    property Menu menu: Menu {
        title: qsTr("Ping actions")
        MenuItem {
            text: "Add device ..."
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
}
