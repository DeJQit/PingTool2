import QtQuick 2.9
import QtQuick.Controls 2.2
import SProcess 1.0

SwipeDelegate {
    id: text

    property string hostname: ""
    property string username: ""

    property alias isRunning: process.isRunning

    signal killProcess

    text: username + " (" + hostname + ") \n" + process.lastReadAll

    SProcess {
        id: process
        property string lastReadAll
        property bool isRunning: false

        onReadyRead: lastReadAll = readAll();

        onStarted: {console.log("Ping Strinted", hostname, "::", username); isRunning = true;}
        onFinished: {console.log("Ping Finished", hostname, "::", username); isRunning = false;}
    }

    onDoubleClicked: if(! swipe.complete) swipe.open(SwipeDelegate.Right);

    Component.onCompleted: process.start("ping", [ hostname ]);
    onKillProcess: {console.log("Ping stop"); process.kill();}
}


