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

    SwipeDelegate {
        id: text
        anchors.centerIn: parent
        width: parent.width
        onClicked: swipe.complete ? swipe.close() : console.log("Click")
        onDoubleClicked: swipe.open(SwipeDelegate.Right)

        swipe.right: Row {
              anchors.right: parent.right
              height: parent.height
              visible: swipe.complete

              Label {
                  id: moveLabel
                  text: qsTr("Move")
                  color: "white"
                  verticalAlignment: Label.AlignVCenter
                  padding: 12
                  height: parent.height

                  SwipeDelegate.onClicked: swipe.close()

                  background: Rectangle {
                      color: moveLabel.SwipeDelegate.pressed ? Qt.darker("#ffbf47", 1.1) : "#ffbf47"
                  }
              }
              Label {
                  id: deleteLabel
                  text: qsTr("Delete")
                  color: "white"
                  verticalAlignment: Label.AlignVCenter
                  padding: 12
                  height: parent.height

                  SwipeDelegate.onClicked: console.log("Deleting...")

                  background: Rectangle {
                      color: deleteLabel.SwipeDelegate.pressed ? Qt.darker("tomato", 1.1) : "tomato"
                  }
              }
        }
    }

    SProcess {
        id: process
        onReadyRead: text.text = "Localhost\n" + readAll();
    }

//    Timer {
//        interval: 1000
//        repeat: false
//        triggeredOnStart: true
//        running: true
//        onTriggered: process.start("ping", [ "google.com" ]);
//    }

    Component.onCompleted: process.start("ping", [ "localhost" ]);
    Component.onDestruction: process.kill();

}
