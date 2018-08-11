import QtQuick 2.9
import QtQuick.Controls 2.2
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
        anchors.fill: parent
        model: pingModel
        delegate: PingDelegate {
            width: parent.width
            hostname: model.hostname
            username: model.username

            onItemRemoved: pingModel.remove(id)
        }
        ScrollBar.vertical: ScrollBar {}
    }
}
