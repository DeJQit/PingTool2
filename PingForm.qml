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

    Label {
        id: text
        anchors.centerIn: parent
    }

    SProcess {
        id: process
        onReadyRead: text.text = readAll();
    }

//    Timer {
//        interval: 1000
//        repeat: false
//        triggeredOnStart: true
//        running: true
//        onTriggered: process.start("ping", [ "google.com" ]);
//    }

    Component.onCompleted: process.start("ping", [ "google.com" ]);
    Component.onDestruction: process.kill();

}
