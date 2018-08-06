import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("PingTool II")

    Shortcut {
        sequence: StandardKey.Quit
        onActivated: window.close()
    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6

            ToolTip.text: qsTr("Application menu")
            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered

            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }

        ToolButton {
            anchors.right: parent.right
            visible: stackView.currentItem.menu !== undefined

            ToolTip.text: stackView.currentItem.menu !== undefined ? stackView.currentItem.menu.title  : ""
            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered

            onClicked: stackView.currentItem.menu.popup()
        }
    }

    DrawerItem {
        id: drawer
        width: window.width * 0.66
        height: window.height
    }

    StackView {
        id: stackView
        initialItem: "PingForm.qml"
        anchors.fill: parent
    }
}
