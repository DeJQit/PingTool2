import QtQuick 2.0

ListModel {
    ListElement {
        title: qsTr("About")
        source: "AboutForm.qml"
    }
    ListElement {
        title: qsTr("Page 2")
        source: "Page2Form.ui.qml"
    }
}
