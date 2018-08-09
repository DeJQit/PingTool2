import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Page {

    title: qsTr("About")

    ColumnLayout {
        spacing: 20

        Label {
            text: Qt.application.name
        }
        Label {
            text: Qt.application.version
        }
        Label {
            text: Qt.application.organization
        }
        Label {
            text: Qt.application.domain
        }
    }

}
