import QtQuick 2.0
import QtQuick.Controls 2.2

Drawer {
    id: drawer

    DrawerModel {
        id: drawerModel
    }

    ListView {
        anchors.fill: parent
        model: drawerModel
        delegate: ItemDelegate {
            text: title
            width: parent.width
            onClicked: {
                stackView.push(model.source)
                drawer.close()
            }
        }
    }
}
