import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import "PhotoViewerCore"

Item {
    id: item1
    property alias button1: button1
    property alias button2: button2

    ColumnLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        transformOrigin: Item.Center
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
        anchors.top: parent

        RowLayout {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
        Button {
            id: button1
            label: qsTr("Como llegar?")
        }

        Button {
            id: button2
            label: qsTr("Historia")
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
