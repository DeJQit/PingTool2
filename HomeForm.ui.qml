import QtQuick 2.9
import QtQuick.Controls 2.2

Page {

    property Menu menu: Menu {
        title: "Home menu"
        MenuItem {
            text: "First"
        }
        MenuItem {
            text: "Second"
        }
    }

    title: qsTr("Home")

    Label {
        text: qsTr("You are on the home page.")
        anchors.centerIn: parent
    }

    RoundButton {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 5
        text: "+"
    }
}
