import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Item {
    property alias button1: button1

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        anchors.top: parent.verticalCenter

        Label {
            text: "N Encuentro Anahi de Rugby infantil!"
            fontSizeMode: Text.HorizontalFit
        }

        Button {
            id: button1
            text: qsTr("Como llegar?")
        }

        Button {
            id: button2
            text: qsTr("Historia")
            onClicked: {
                engine.launchHistoria();
            }
        }

    }

    Image {
        id: bgImage
        z: -1
        anchors.fill: parent
        antialiasing: true
        transformOrigin: Item.TopLeft
        fillMode: Image.PreserveAspectFit
        source: "qrc:///images/photo.jpg"
    }

}
