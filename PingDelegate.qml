import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import SProcess 1.0

SwipeDelegate {
    id: rootItem

    property string hostname: ""
    property string username: ""

    signal killProcess

    anchors { left: parent.left; right: parent.right }

    SProcess {
        id: process
        property string lastString

        onReadyReadStandardOutput: lastString = String(readAllStandardOutput()).trim()
        onReadyReadStandardError:  lastString = qsTr("Error: ") + String(readAllStandardError()).trim()
    }

    text: username + " (" + hostname + ") \n" + process.lastString

    contentItem: Text {
             text: rootItem.text
             font: rootItem.font
             color: Material.foreground
             wrapMode: Text.WordWrap
             verticalAlignment: Text.AlignVCenter
         }

    ListView.onRemove: SequentialAnimation {
        PropertyAction { target: pingDelegate; property: "ListView.delayRemove"; value: true }
        ScriptAction {script: killProcess();}
        NumberAnimation {target: pingDelegate; property: "scale"; to: 0; duration: 250; easing.type: Easing.InOutQuad }
        PropertyAction { target: pingDelegate; property: "ListView.delayRemove"; value: false }
    }

    Component.onCompleted: process.start("ping", [ hostname ]);
    onKillProcess: {console.log("Ping stop"); process.kill();}
}


