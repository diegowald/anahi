import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import Backend 1.0
import "PhotoViewerCore"

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Anahi")

    /*    header: Label {
        id: timerLabel
    }*/

    header: RowLayout {
        spacing: 2
        Image {
            id: image
            width: 100
            height: 100
            source: "qrc:/ui/iconoAnahi48x48.png"
        }
        ColumnLayout {
            spacing: 2
            Label {
                id: headerLabel
                text: "XI Encuentro Nacional de Rugby Infantil"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.pointSize: 14
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.HorizontalFit
                font.bold: true
            }
            Label {
                text: "Anahi Menna de Vila"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.pointSize: 14
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.HorizontalFit
            }
        }
    }


    SwipeView {
        id: swipeView
        antialiasing: true
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1 {
        }

        Page {
            opacity: 0.8
            ColumnLayout {
                ListView {
                    id: listViewClubes
                    width: 360
                    height: 400
                    signal pressAndHold(int index)

                    focus: true
                    boundsBehavior: Flickable.StopAtBounds

                    section.property: "categoria"
                    section.criteria: ViewSection.FullString
                    section.delegate: SectionDelegate {
                        width: listView.width
                    }

                    delegate: ClubesDelegate {
                        id: delegateClubes
                        width: listView.width
                        Connections {
                            target: delegateClubes
                            onPressAndHold: listView.pressAndHold(index)
                        }
                    }

                    model: ClubesModel {
                        id: clubesModel
                    }


                    ScrollBar.vertical: ScrollBar {}

                }
            }
        }

        /*Page {
            opacity: 0.8
            ColumnLayout {
                anchors.fill: parent
                Label {
                    text: qsTr("Canchas")
                }
                Label {
                    text: "Aca puede estar el diagrama de ubicacion de las canchas. Banios, 3er tiempo. Donde comprar comida"
                }
                Label {
                    text: "CONSEGUIR ESQUEMA DE DISTRIBUCION DE CANCHAS / BANIOS / ETC"
                }
            }
        }*/

        Page {
            opacity: 0.8
            ColumnLayout {
                //anchors.fill: parent
                ListView {
                    id: listView
                    width: 360
                    height: 400
                    Layout.fillWidth: true
                    signal pressAndHold(int index)


                    focus: true
                    boundsBehavior: Flickable.StopAtBounds

                    section.property: "categoria"
                    section.criteria: ViewSection.FullString
                    section.delegate: SectionDelegate {
                        width: listView.width
                    }

                    delegate: DatosUtilesDelegate {
                        id: delegate
                        width: listView.width
                        Connections {
                            target: delegate
                            onPressAndHold: listView.pressAndHold(index)
                        }
                        background: Rectangle {
                            color: "transparent"
                        }
                    }

                    model: DatosUtilesModel {
                        id: datosUtilesModel
                    }

                    ScrollBar.vertical: ScrollBar {}

                }
            }
        }

        /*Page5 {
            opacity: 0.8
        }*/

    }

    /*background: Image {
        id: imageBackground
        anchors.fill: parent
        antialiasing: true
        transformOrigin: Item.TopLeft
        fillMode: Image.PreserveAspectFit
        source: engine.getBackgroundImage()
    }
    */

    background: Item {
        id: backgroundItem
        anchors.fill: parent
        states: [
            State { // this will fade in rect2 and fade out rect
                name: "fadeInRect2"
                PropertyChanges { target: rect; opacity: 0}
                PropertyChanges { target: rect2; opacity: 1}
                PropertyChanges { target: rect2; source: engine.getBackgroundImage()}
            },
            State   { // this will fade in rect and fade out rect2
                name:"fadeOutRect2"
                PropertyChanges { target: rect;opacity:1}
                PropertyChanges { target: rect2;opacity:0}
                PropertyChanges { target: rect; source: engine.getBackgroundImage()}
            }
        ]

        state: "fadeInRect2"

        transitions: [
            Transition {
                NumberAnimation { property: "opacity"; easing.type: Easing.InOutQuad; duration: 1500  }
            }
        ]

        Image {
            id: rect2
            smooth: true
            opacity: 0
            anchors.fill: parent
            antialiasing: true
            transformOrigin: Item.TopLeft
            fillMode: Image.PreserveAspectFit
            source: engine.getBackgroundImage()
        }

        Image {
            id: rect
            smooth: true
            anchors.fill: parent
            opacity: 1
            antialiasing: true
            transformOrigin: Item.TopLeft
            fillMode: Image.PreserveAspectFit
            source: engine.getBackgroundImage()
        }

        function toggle()   {
            backgroundItem.state = backgroundItem.state == "fadeInRect2" ? "fadeOutRect2" : "fadeInRect2"
        }
    }


    footer: ColumnLayout {
        antialiasing: true
        spacing: 2
        Image {
            id: auspiciante
            source: engine.getImageAuspiciante(0)
            property string url: engine.getURLAuspiciante(0)
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            height: 150
            MouseArea {
                anchors.fill: auspiciante
                onClicked: {
                    console.info("click");
                    console.info(auspiciante.url);
                    engine.launchURL(auspiciante.url);
                }
            }
        }

        TabBar {
            id: tabBar
            currentIndex: swipeView.currentIndex
            TabButton {
                text: qsTr("Anahi")
            }
            TabButton {
                text: qsTr("Clubes")
            }
            /*TabButton {
                text: qsTr("Canchas")
            }*/
            TabButton {
                text: qsTr("INFO")
            }
            /*TabButton {
                text: qsTr("Fotos")
            }*/
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: {
            //imageBackground.source = engine.getBackgroundImage();
            backgroundItem.toggle();
            console.info("toggle");
        }
    }

    Timer {
        interval: 4000
        running: true
        repeat: true
        onTriggered: {
            var idAuspiciante = engine.getIdAuspiciante();
            auspiciante.source = engine.getImageAuspiciante(idAuspiciante);
            auspiciante.url = engine.getURLAuspiciante(idAuspiciante);
        }
    }
}
