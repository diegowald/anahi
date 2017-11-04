import QtQuick 2.7

Page1Form {
    button1.onClicked: {
        engine.launchMap();
    }

    button2.onClicked: {
        engine.launchHistoria();
    }

    descargarRevista.onClicked: {
        engine.download("https://drive.google.com/file/d/0B_JM9iwTrDXSd0hoR3ByVlJ1RVk/view?usp=sharing");
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        onTriggered: {
            descargarRevista.visible = engine.downloadEnabled();
        }
    }

}
