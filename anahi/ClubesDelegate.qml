
import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1

ItemDelegate {
    id: delegateClubes

    //property bool checkable: true
    checkable: true


    contentItem: ColumnLayout {
        spacing: 40

        RowLayout {
            Image {
                id: imagenClub
                width: 40
                height: 40
                fillMode: Image.PreserveAspectFit
                source: logo

                /*property string url: engine.getURLAuspiciante(0)
            MouseArea {
                anchors.fill: auspiciante
                onClicked: {
                    console.info("click");
                    console.info(auspiciante.url);
                    engine.launchURL(auspiciante.url);
                }
            }*/
            }

            Label {
                text: fullName
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }

        GridLayout {
            id: grid
            visible: false

            columns: 2
            rowSpacing: 10
            columnSpacing: 10

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

        }
    }

    states: [
        State {
            name: "expanded"
            when: delegateClubes.checked

            PropertyChanges {
                target: grid
                visible: true
            }
        }
    ]
}
