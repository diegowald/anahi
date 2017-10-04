import QtQuick 2.7
import QtQuick.Controls 2.1

ToolBar {
    id: background

    Label {
        id: label
        text: section
        opacity: 0.6
        renderType: Text.NativeRendering
        anchors.fill: parent
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
    }
}
