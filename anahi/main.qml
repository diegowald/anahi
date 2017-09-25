import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")


    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1 {
        }

        Page {
            ColumnLayout {
                anchors.fill: parent
                Label {
                    text: qsTr("Canchas")
                }
                Label {
                    text: "Aca puede estar el diagrama de ubicacion de las canchas. Banios, 3er tiempo. Donde comprar comida"
                }
            }
        }

        Page {
            ColumnLayout {
                anchors.fill: parent
                Label {
                    text: qsTr("Datos utiles")
                    anchors.centerIn: parent
                }
                Label {
                    text: "Posiblemente algunos telefonos..."
                }
            }
        }

        Page5 {

        }

    }

    Label {
        id: timerLabel
    }
    Image {
        id: auspiciante
        source: engine.getImageAuspiciante(0)
        property string url: engine.getURLAuspiciante(0)
        MouseArea {
            anchors.fill: auspiciante
            onClicked: {
                console.info("click");
                console.info(auspiciante.url);
                engine.launchURL(auspiciante.url);
            }
        }
    }
    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Anahi 2017")
        }
        TabButton {
            text: qsTr("Canchas")
        }
        TabButton {
            text: qsTr("Datos utiles")
        }
        TabButton {
            text: qsTr("Fotos")
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: timerLabel.text = Date().toString();
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            var idAuspiciante = engine.getIdAuspiciante();
            auspiciante.source = engine.getImageAuspiciante(idAuspiciante);
            auspiciante.url = engine.getURLAuspiciante(idAuspiciante);
        }
    }
}
