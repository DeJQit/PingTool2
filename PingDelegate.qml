import QtQuick 2.9
import QtQuick.Controls 2.2
import SProcess 1.0

SwipeDelegate {
    id: text

    property string hostname: ""
    property string username: ""

    signal itemRemoved

    text: username + " (" + hostname + ") \n" + process.lastReadAll

    SProcess {
        id: process
        property string lastReadAll
        onReadyRead: lastReadAll = readAll();

        onStarted: console.log("Ping Strinted")
        onFinished: console.log("Ping Finished")
    }


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

              SwipeDelegate.onClicked: itemRemoved();

              background: Rectangle {
                  color: deleteLabel.SwipeDelegate.pressed ? Qt.darker("tomato", 1.1) : "tomato"
              }
          }
    }

    onClicked: swipe.complete ? swipe.close() : console.log("Click")
    onDoubleClicked: swipe.open(SwipeDelegate.Right)

    Component.onCompleted: process.start("ping", [ hostname ]);
    Component.onDestruction: process.kill();
}


