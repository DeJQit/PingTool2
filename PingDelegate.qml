import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import SProcess 1.0

SwipeDelegate {
    id: rootItem

    property string hostname: ""
    property string username: ""

    signal killProcess
    signal startProcess

    anchors { left: parent.left; right: parent.right }

    SProcess {
        id: process
        property string lastString

        onReadyReadStandardOutput: lastString = String(readAllStandardOutput()).trim()
        onReadyReadStandardError:  lastString = qsTr("Error: ") + String(readAllStandardError()).trim()
        onStarted: lastString = qsTr("Ping started ...")
        onFinished: lastString += qsTr("(Ping finished)")
    }

    contentItem: Column {

        Label {
            width: rootItem.width
            text: username + " (" + hostname + ")"
            wrapMode: Label.Wrap
        }

        Label {
            width: rootItem.width
            text: process.lastString
            wrapMode: Label.Wrap
        }
    }

    ListView.onRemove: SequentialAnimation {
        PropertyAction { target: pingDelegate; property: "ListView.delayRemove"; value: true }
        ScriptAction {script: killProcess();}
        NumberAnimation {target: pingDelegate; property: "scale"; to: 0; duration: 250; easing.type: Easing.InOutQuad }
        PropertyAction { target: pingDelegate; property: "ListView.delayRemove"; value: false }
    }

    Component.onCompleted: startProcess();
    onStartProcess: {
        if(Qt.platform.os === "linux" || Qt.platform.os === "unix") {
            process.start("ping", ["-O", hostname ]);
        } else if(Qt.platform.os === "windows") {
            process.start("ping", ["-t", hostname ]);
        }
    }
    onKillProcess: {
        process.kill();
    }
}


