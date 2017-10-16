import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import Backend 1.0
import QtPositioning 5.8
import QtLocation 5.9
import "PhotoViewerCore"

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Anahi")

    /*    header: Label {
        id: timerLabel
    }*/

    property variant locationClub: QtPositioning.coordinate( -38.715921, -62.208452 )


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
        clip: true
        id: swipeView
        antialiasing: true
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        opacity: 0.8

        Page1 {
        //    opacity: 0.8
        }

        Page {
          //  opacity: 0.8
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

        Page {
            Plugin {
                id: mapPlugin
                name: "osm" // "mapboxgl", "esri", ...
                //specify plugin parameters if necessary
                //PluginParameter {...}
                //PluginParameter {...}
                //...
            }

            opacity: 0.8
            ColumnLayout {
                anchors.fill: parent




                PositionSource {
                    id: positionSource
                    property variant lastSearchPosition: locationClub
                    active: true
                    updateInterval: 120000 // 2 mins
                    onPositionChanged:  {
                        var currentPosition = positionSource.position.coordinate
                        var distance = currentPosition.distanceTo(lastSearchPosition)
                        if (distance < 2000) {
                            map.center = currentPosition
                            lastSearchPosition = currentPosition
                          //  searchModel.searchArea = QtPositioning.circle(currentPosition)
                          //  searchModel.update()
                        }
                        else {
                            map.center = locationClub
                        }
                    }
                }

                Map {
                    RowLayout {
                        width: parent.width
                        Label {
                            text: qsTr("Mostrar")
                        }

                        ComboBox {
                            id: comboMuestra
                            currentIndex: 0

                            model: [
                                "Todo",
                                "Estacionamiento",
                                "Baños",
                                "3er Tiempo",
                                "Comprar",
                                "Canchas Escuelita",
                                "Canchas M8-M9",
                                "Canchas M10",
                                "Canchas M11",
                                "Canchas M12",
                                "Canchas M13",
                                "Canchas M14"
                            ]
                        }
                    }

                    id: map
                    anchors.fill: parent
                    plugin: mapPlugin;
                    center: locationClub
                    zoomLevel: 16
                }

                Map {
                    id: mapOverlay
                    color: "transparent"
                    anchors.fill: parent
                    plugin: Plugin {
                        name: "itemsoverlay"
                    }
                    gesture.enabled: false
                    center: map.center

                    minimumFieldOfView: map.minimumFieldOfView
                    maximumFieldOfView: map.maximumFieldOfView

                    minimumTilt: map.minimumTilt
                    maximumTilt: map.maximumTilt

                    minimumZoomLevel: map.minimumZoomLevel
                    maximumZoomLevel: map.maximumZoomLevel

                    zoomLevel: map.zoomLevel

                    tilt: map.tilt

                    bearing: map.bearing
                    fieldOfView: map.fieldOfView

                    z: map.z + 1


                    MapPolygon {
                        id: estacionamiento
                        color: "gray"
                        MouseArea {
                            id: estacienamientoMA
                            anchors.fill: parent
                        }

                        opacity: 0.5

                        path: [
                            { latitude: -38.7110903, longitude: -62.2086132 },
                            { latitude: -38.7143384, longitude: -62.2038925 },
                            { latitude: -38.7152258, longitude: -62.2048903 },
                            { latitude: -38.7118353, longitude: -62.2095144}
                        ]
                        ToolTip.visible: estacienamientoMA.pressed
                        ToolTip.text: "Estacionamiento"

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                estacionamiento.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 1));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasEscuelita
                    }

                    MapPolygon {
                        id: canchasM8M9
                    }

                    MapPolygon {
                        id: canchasM10
                    }

                    MapPolygon {
                        id: canchasM11
                    }

                    MapPolygon {
                        id: canchasM12
                    }

                    MapPolygon {
                        id: canchasM13
                    }

                    MapPolygon {
                        id: canchasM14
                    }

                    MapCircle {
                        id: casitaAzul
                    }

                    MapCircle {
                        id: clubHouse
                    }

                    MapPolygon {
                        id: banios
                    }

                    MapPolygon {
                        id: sector3erTiempo
                    }


                    layer.enabled: true
                    layer.smooth: true
                    property int w: mapOverlay.width
                    property int h: mapOverlay.height
                    //property int pr: Screen.devicePixelRatio
                      layer.textureSize: Qt.size(w  * 2 /** pr*/, h * 2 /** pr*/)
                }
            }
        }

        Page {
        //    opacity: 0.8
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
            Layout.fillWidth: true
            currentIndex: swipeView.currentIndex
            TabButton {
                text: qsTr("Anahí")
                font.capitalization: Font.Capitalize
            }
            TabButton {
                text: qsTr("Clubes")
                font.capitalization: Font.Capitalize
            }
            TabButton {
                text: qsTr("Canchas")
                font.capitalization: Font.Capitalize
            }
            TabButton {
                width: 65
                text: qsTr("Info")
                font.capitalization: Font.Capitalize
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
