import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "PhotoViewerCore"

Item {
    id: item1
    property alias button1: button1
    property alias button2: button2
    property alias descargarRevista: descargarRevista

    Rectangle {
        color: "#ffffff"
        anchors.fill: parent
    }

    ColumnLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        transformOrigin: Item.Center
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        //anchors.top: parent.top

        RowLayout {
            spacing: 1
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true

            Button {
                id: button1
                label: qsTr("Cómo llegar?")
            }

            Button {
                id: descargarRevista
                label: "Revista"
                property date currentDate: new Date()
                visible: engine.downloadEnabled();
            }

            Button {
                id: button2
                label: qsTr("Historia")
            }

        }
    }

    Text {
        id: text1
        height: 328
        text: "CRONOGRAMA DE ACTIVIDADES \n\nViernes 3 de Noviembre \nde 19 a 21 hs arribo de las distintas delegaciones de otras Uniones \n                        Alojadas en casas de familia y traslado a hotel de delegaciones.\n                        Cena de Bienvenida.\n\nSábado 4 de Noviembre \n       9 hs Acreditacion de Equipos intervinientes en el Encuentro\n    10 hs  Apertura del Encuentro a cargo de autoridades Municipales y banda del Ejército.\n               Desarrollo del Encuentro\n     de 12,30 a 14 hs Terceros tiempos disponibles para ser consumidos.\n     13,30 Actuación de bsanda Musical LA CHANCHA \n     14 hs Comienza M14 con su actividad.\n     21,30 hs Cena de Camaradería para las delegaciones que participaron en el Encuentro.\n\nDomingo 5 de Noviembre \n      10 hs Inbicio de seguanda jornada del Encuentro \n       14 hs Finalización del Encuentro con Tercer Tiempo.-"
        textFormat: Text.PlainText
        font.weight: Font.ExtraBold
        verticalAlignment: Text.AlignTop
        clip: false
        anchors.right: parent.right
        anchors.rightMargin: 3
        anchors.top: parent.top
        anchors.topMargin: 2
        font.bold: true
        fontSizeMode: Text.HorizontalFit
        wrapMode: Text.WordWrap
        anchors.left: parent.left
        anchors.leftMargin: 2
        renderType: Text.NativeRendering
        font.pixelSize: 14
    }


}
