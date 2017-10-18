import QtQuick 2.7

Page1Form {
    button1.onClicked: {
        engine.launchMap();
    }

    button2.onClicked: {
        engine.launchHistoria();
    }

    descargarRevista.onClicked: {
        engine.download("https://drive.google.com/open?id=0B_JM9iwTrDXSaUtNTDVOZ3E3Qk0");
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
