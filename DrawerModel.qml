import QtQuick 2.0

ListModel {
    ListElement {
        title: qsTr("About")
        source: "AboutForm.qml"
    }
    ListElement {
        title: qsTr("Exit")
        source: "ExitForm.qml"
    }
}
