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
                            z: map.z + 2


                            model: [
                                "Todo",
                                "Estacionamiento",
                                "Baños",
                                "3er Tiempo",
                                "Compras",
                                "Escuelita",
                                "M8-M9",
                                "M10",
                                "M11",
                                "M12",
                                "M13"
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
                        opacity: 0.5

                        path: [
                            { latitude: -38.7110903, longitude: -62.2086132 },
                            { latitude: -38.7143384, longitude: -62.2038925 },
                            { latitude: -38.7152258, longitude: -62.2048903 },
                            { latitude: -38.7118353, longitude: -62.2095144}
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                estacionamiento.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 1));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblEstacionamiento
                        coordinate: QtPositioning.coordinate(-38.71312245, -62.2067276 )
                        anchorPoint.x: l1.width / 2
                        anchorPoint.y : l1.height / 2

                        sourceItem: Label {
                            id:l1
                            text: "Estacionamiento"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblEstacionamiento.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 1));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasEscuelitaM8
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7150259, longitude: -62.2082591 },
                            { latitude: -38.7147423, longitude: -62.2086239 },
                            { latitude: -38.7145592, longitude: -62.2083718 },
                            { latitude: -38.7148438, longitude: -62.2080177 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasEscuelitaM8.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 5));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasEscuelitaM8
                        coordinate: QtPositioning.coordinate(-38.7147928, -62.208318125)
                        anchorPoint.x: lCanchasEscuelitaM8.width / 2
                        anchorPoint.y : lCanchasEscuelitaM8.height / 2
                        sourceItem: Label {
                            id: lCanchasEscuelitaM8
                            text: "Cancha Escuelita y M8"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasEscuelitaM8.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 5));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasM9
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7146377, longitude: -62.2076154 },
                            { latitude: -38.7148867, longitude: -62.2073123 },
                            { latitude: -38.7150667, longitude: -62.2075295 },
                            { latitude: -38.7148093, longitude: -62.2078407 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM9.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 6));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM9
                        coordinate: QtPositioning.coordinate(-38.7148501, -62.207574475)
                        anchorPoint.x: lblM9.width / 2
                        anchorPoint.y : lblM9.height / 2
                        sourceItem: Label {
                            id: lblM9
                            text: "Cancha M9"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM9.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 6));
                            }
                        }
                    }


                    MapPolygon {
                        id: canchasM9_2
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7150908, longitude: -62.207547 },
                            { latitude: -38.7148875, longitude: -62.2073132 },
                            { latitude: -38.7151389, longitude: -62.2070078 },
                            { latitude: -38.7153252, longitude: -62.2072385 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM9_2.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 6));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM9_2
                        coordinate: QtPositioning.coordinate(-38.7151106, -62.207276625)
                        anchorPoint.x: lblM9_2.width / 2
                        anchorPoint.y : lblM9_2.height / 2
                        sourceItem: Label {
                            id: lblM9_2
                            text: "Cancha M9"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM9_2.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 6));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasM10
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7155439, longitude: -62.2070226 },
                            { latitude: -38.715344, longitude: -62.2072694 },
                            { latitude: -38.7151316, longitude: -62.2069985 },
                            { latitude: -38.7153419, longitude: -62.2067437 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM10.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 7));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM10
                        coordinate: QtPositioning.coordinate(-38.71534035, -62.20700855)
                        anchorPoint.x: lCanchasM10.width / 2
                        anchorPoint.y : lCanchasM10.height / 2
                        sourceItem: Label {
                            id: lCanchasM10
                            text: "Cancha M10"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM10.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 7));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasM8M9
                    }



                    MapPolygon {
                        id: canchasM10_2
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7154623, longitude: -62.20772 },
                            { latitude: -38.7152593, longitude: -62.2074518 },
                            { latitude: -38.7155732, longitude: -62.2070655 },
                            { latitude: -38.7157741, longitude: -62.2073418 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM10_2.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 7));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM10_2
                        coordinate: QtPositioning.coordinate(-38.715517225, -62.207394775)
                        anchorPoint.x: lCanchasM10_2.width / 2
                        anchorPoint.y : lCanchasM10_2.height / 2
                        sourceItem: Label {
                            id: lCanchasM10_2
                            text: "Cancha M10 2"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM10_2.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 7));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasM10_3
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7165662, longitude: -62.2075262 },
                            { latitude: -38.7168561, longitude: -62.2078916 },
                            { latitude: -38.7166426, longitude: -62.2081625 },
                            { latitude: -38.7163454, longitude: -62.2078139 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM10_3.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 7));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM10_3
                        coordinate: QtPositioning.coordinate(-38.716602575, -62.20784855)
                        anchorPoint.x: lCanchasM10_3.width / 2
                        anchorPoint.y : lCanchasM10_3.height / 2
                        sourceItem: Label {
                            id: lCanchasM10_3
                            text: "Cancha M10 3"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM10_3.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 7));
                            }
                        }
                    }


                    MapPolygon {
                        id: canchasM11_1
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.716155, longitude: -62.2080714 },
                            { latitude: -38.7164417, longitude: -62.2084308 },
                            { latitude: -38.7166426, longitude: -62.2081625 },
                            { latitude: -38.7163454, longitude: -62.2078139 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM11_1.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 8));
                            }
                        }
                    }



                    MapQuickItem {
                        id: lblCanchasM11_1
                        coordinate: QtPositioning.coordinate(-38.716396175, -62.20811965)
                        anchorPoint.x: lCanchasM11_1.width / 2
                        anchorPoint.y : lCanchasM11_1.height / 2
                        sourceItem: Label {
                            id: lCanchasM11_1
                            text: "Cancha M11 1"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM11_1.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 8));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasM11_2
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7166426, longitude: -62.2081625 },
                            { latitude: -38.7169565, longitude: -62.2085354 },
                            { latitude: -38.7167431, longitude: -62.2088143 },
                            { latitude: -38.7164417, longitude: -62.2084308 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM11_2.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 8));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM11_2
                        coordinate: QtPositioning.coordinate(-38.716695975, -62.20848575)
                        anchorPoint.x: lCanchasM11_2.width / 2
                        anchorPoint.y : lCanchasM11_2.height / 2
                        sourceItem: Label {
                            id: lCanchasM11_2
                            text: "Cancha M11 2"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM11_2.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 8));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasM11_3
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7166426, longitude: -62.2081625 },
                            { latitude: -38.7168561, longitude: -62.2078916 },
                            { latitude: -38.7171616, longitude: -62.2082645 },
                            { latitude: -38.7169565, longitude: -62.2085354 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM11_3.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 8));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM11_3
                        coordinate: QtPositioning.coordinate(-38.7169042, -62.2082135)
                        anchorPoint.x: lCanchasM11_3.width / 2
                        anchorPoint.y : lCanchasM11_3.height / 2
                        sourceItem: Label {
                            id: lCanchasM11_3
                            text: "Cancha M11 3"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM11_3.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 8));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasM12
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7140768, longitude: -62.2068483 },
                            { latitude: -38.7147716, longitude: -62.2059873 },
                            { latitude: -38.7152258, longitude: -62.2066015 },
                            { latitude: -38.7145247, longitude: -62.2074518 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM12.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 9));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM12
                        coordinate: QtPositioning.coordinate(-38.714649725, -62.206722225)
                        anchorPoint.x: lCanchasM12.width / 2
                        anchorPoint.y : lCanchasM12.height / 2
                        sourceItem: Label {
                            id: lCanchasM12
                            text: "Cancha M12"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM12.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 9));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasM12_2
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.715772, longitude: -62.207197 },
                            { latitude: -38.7155355, longitude: -62.2068965 },
                            { latitude: -38.7158327, longitude: -62.2064942 },
                            { latitude: -38.7160859, longitude: -62.2067919 }

                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM12_2.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 9));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM12_2
                        coordinate: QtPositioning.coordinate(-38.715806525, -62.2068449)
                        anchorPoint.x: lCanchasM12_2.width / 2
                        anchorPoint.y : lCanchasM12_2.height / 2
                        sourceItem: Label {
                            id: lCanchasM12_2
                            text: "Cancha M12 2"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM12_2.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 9));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasM13
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7143656, longitude: -62.2086212 },
                            { latitude: -38.7135766, longitude: -62.2075886 },
                            { latitude: -38.714058, longitude: -62.2069717 },
                            { latitude: -38.7148574, longitude: -62.2080016 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM13.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 10));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM13
                        coordinate: QtPositioning.coordinate(-38.7142144, -62.207795775)
                        anchorPoint.x: lCanchasM13.width / 2
                        anchorPoint.y : lCanchasM13.height / 2
                        sourceItem: Label {
                            id: lCanchasM13
                            text: "Cancha M13"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM13.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 10));
                            }
                        }
                    }

                    MapPolygon {
                        id: canchasM13_2
                        color: "lightgreen"

                        opacity: 0.5

                        path: [
                            { latitude: -38.7150719, longitude: -62.2082001 },
                            { latitude: -38.714802, longitude: -62.207838 },
                            { latitude: -38.71514, longitude: -62.2074303 },
                            { latitude: -38.7154058, longitude: -62.2077978 }
                        ]

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                canchasM13_2.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 10));
                            }
                        }
                    }

                    MapQuickItem {
                        id: lblCanchasM13_2
                        coordinate: QtPositioning.coordinate(-38.715104925, -62.20781655)
                        anchorPoint.x: lCanchasM13_2.width / 2
                        anchorPoint.y : lCanchasM13_2.height / 2
                        sourceItem: Label {
                            id: lCanchasM13_2
                            text: "Cancha M13"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                lblCanchasM13_2.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 10));
                            }
                        }
                    }


                    MapQuickItem {
                        id: casitaAzul
                        coordinate: QtPositioning.coordinate(-38.7146021, -62.2074947)

                        anchorPoint.x: lcasitaAzul.width / 2
                        anchorPoint.y : lcasitaAzul.height / 2
                        sourceItem: ColumnLayout {
                            Image {
                                id: imageCasitaAzul
                                width: 100
                                height: 100
                                source: "qrc:/ui/restaurant.png"
                            }
                            Label {
                            id: lcasitaAzul
                            text: "Parrilla"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                            }
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                casitaAzul.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 5));
                            }
                        }
                    }

                    MapQuickItem {
                        id: clubHouse
                        coordinate: QtPositioning.coordinate(-38.7161215, -62.2065103)
                        anchorPoint.x: lCanchasM10.width / 2
                        anchorPoint.y : lCanchasM10.height / 2
                        sourceItem: ColumnLayout {
                            Image {
                                id: imageClubHouse
                                width: 100
                                height: 100
                                source: "qrc:/ui/restaurant.png"
                            }
                            Label {
                                id: lclubHouse
                                text: "Confitería"
                                font.pixelSize: 12
                                color: "black"
                                font.bold: true
                            }
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                clubHouse.visible = ((comboMuestra.currentIndex == 0) || (comboMuestra.currentIndex == 5));
                            }
                        }
                    }


                    MapQuickItem {
                        id: controlCentral
                        coordinate: QtPositioning.coordinate(-38.7152258, -62.2067356)
                        anchorPoint.x: lcontrolCentral.width / 2
                        anchorPoint.y : lcontrolCentral.height / 2
                        sourceItem: ColumnLayout {
                            Image {
                                id: imageControlCentral
                                width: 100
                                height: 100
                                source: "qrc:/ui/controlCentral.png"
                            }
                            Label {
                            id: lcontrolCentral
                            text: "Control Central"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                            }
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                controlCentral.visible = (comboMuestra.currentIndex == 0)
                            }
                        }
                    }

                    MapQuickItem {
                        id: banios1
                        coordinate: QtPositioning.coordinate(-38.7145477, -62.2087258)
                        anchorPoint.x: lbanios.width / 2
                        anchorPoint.y : lbanios.height / 2
                        sourceItem: Label {
                            id: lbanios
                            text: "Baños"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                controlCentral.visible = (comboMuestra.currentIndex == 0)
                            }
                        }
                    }

                    MapQuickItem {
                        id: banios2
                        coordinate: QtPositioning.coordinate(-38.7154602, -62.2056198)
                        anchorPoint.x: lbanios2.width / 2
                        anchorPoint.y : lbanios2.height / 2
                        sourceItem: Label {
                            id: lbanios2
                            text: "Baños y Vestuario"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                controlCentral.visible = (comboMuestra.currentIndex == 0)
                            }
                        }
                    }

                    MapQuickItem {
                        id: banios3
                        coordinate: QtPositioning.coordinate(-38.7162722, -62.2076798)
                        anchorPoint.x: lbanios3.width / 2
                        anchorPoint.y : lbanios3.height / 2
                        sourceItem: Label {
                            id: lbanios3
                            text: "Baños"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                controlCentral.visible = (comboMuestra.currentIndex == 0)
                            }
                        }
                    }

                    MapQuickItem {
                        id: sector3erTiempoJugadores
                        coordinate: QtPositioning.coordinate(-38.715615, -62.2057968)
                        anchorPoint.x: lSector3erTiempoJugadores.width / 2
                        anchorPoint.y : lSector3erTiempoJugadores.height / 2
                        sourceItem: Label {
                            id: lSector3erTiempoJugadores
                            text: "3er Tiempo Jugadores"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                controlCentral.visible = (comboMuestra.currentIndex == 0)
                            }
                        }
                    }

                    MapQuickItem {
                        id: sector3erTiempoEntrenadores
                        coordinate: QtPositioning.coordinate(-38.7158076, -62.2061294)
                        anchorPoint.x: lSector3erTiempoEntrenadores.width / 2
                        anchorPoint.y : lSector3erTiempoEntrenadores.height / 2

                        sourceItem: Label {
                            id: lSector3erTiempoEntrenadores
                            text: "3er Tiempo Entrenadores"
                            font.pixelSize: 12
                            color: "black"
                            font.bold: true
                        }

                        Connections {
                            target: comboMuestra
                            onCurrentIndexChanged: {
                                controlCentral.visible = (comboMuestra.currentIndex == 0)
                            }
                        }
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
            ColumnLayout {
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
            backgroundItem.toggle();
            console.info("toggle");
        }
    }

}
