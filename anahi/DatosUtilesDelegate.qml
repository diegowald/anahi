
import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

ItemDelegate {
    id: delegate

    //property bool checkable: true
    checkable: true


    contentItem: ColumnLayout {
        spacing: 10

        Label {
            text: fullName
            font.bold: true
            elide: Text.ElideRight
            Layout.fillWidth: true
        }

        GridLayout {
            id: grid
            visible: false

            columns: 2
            rowSpacing: 10
            columnSpacing: 10

            Label {
                text: "Direccion:"
                Layout.leftMargin: 60
            }

            Label {
                text: address
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            Label {
                text: "Ciudad:"
                Layout.leftMargin: 60
            }

            Label {
                text: city
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            Label {
                text: "Numero:"
                Layout.leftMargin: 60
            }

            Label {
                text: number
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }
    }

    states: [
        State {
            name: "expanded"
            when: delegate.checked

            PropertyChanges {
                target: grid
                visible: true
            }
        }
    ]
}
