import QtQuick 2.0
import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQml.Models 2.1
import "PhotoViewerCore"

Item {
    id: page5Form

    visible: true

    Rectangle {
        focus: true

        Keys.onBackPressed: {
            event.accepted = true
            backButton.clicked()
        }
    }

    property real downloadProgress: 0
    property bool imageLoading: false
    property bool editMode: false

    width: 800; height: 480; //color: "#d5d6d8"

    ListModel {
        id: photosModel
        ListElement { tag: "Rugby" }
    }

    DelegateModel { id: albumVisualModel; model: photosModel; delegate: AlbumDelegate {} }

    GridView {
        id: albumView; width: parent.width; height: parent.height; cellWidth: 210; cellHeight: 220
        model: albumVisualModel.parts.album; visible: albumsShade.opacity != 1.0
    }

    /*Column {
        spacing: 20; anchors { bottom: parent.bottom; right: parent.right; rightMargin: 20; bottomMargin: 20 }
        Button {
            id: newButton; label: qsTr("Add"); rotation: 3
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                page5Form.editMode = false
                photosModel.append( { tag: "" } )
                albumView.positionViewAtIndex(albumView.count - 1, GridView.Contain)
            }
        }
        Button {
            id: deleteButton; label: qsTr("Edit"); rotation: -2;
            onClicked: page5Form.editMode = !page5Form.editMode
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Button {
            id: quitButton; label: qsTr("Quit"); rotation: -2;
            onClicked: Qt.quit()
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }*/

    Rectangle {
        id: albumsShade; //color: page5Form.color
        width: parent.width; height: parent.height; opacity: 0.0
    }

    ListView { anchors.fill: parent; model: albumVisualModel.parts.browser; interactive: false }

    Button {
        id: backButton
        label: qsTr("Volver")
        rotation: 3
        x: parent.width - backButton.width - 6
        y: -backButton.height - 8
        //visible: Qt.platform.os !== "android"
    }

    Rectangle { id: photosShade; color: 'black'; width: parent.width; height: parent.height; opacity: 0; visible: opacity != 0.0 }

    ListView { anchors.fill: parent; model: albumVisualModel.parts.fullscreen; interactive: false }

    Item { id: foreground; anchors.fill: parent }

    ProgressBar {
        progress: page5Form.downloadProgress; width: parent.width; height: 4
        anchors.bottom: parent.bottom; opacity: page5Form.imageLoading; visible: opacity != 0.0
    }
}
