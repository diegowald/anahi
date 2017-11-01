import QtQuick 2.7

Page1Form {
    button1.onClicked: {
        engine.launchMap();
    }

    button2.onClicked: {
        engine.launchHistoria();
    }

    descargarRevista.onClicked: {
        engine.download("https://doc-0c-c0-docs.googleusercontent.com/docs/securesc/9pgohaprbfgq35abvopm1t0lromtv9ph/q9vetbphro3ofqoku1og8ir23cf9fg14/1509451200000/17964517950155669863/17964517950155669863/0B_JM9iwTrDXSd0hoR3ByVlJ1RVk?e=download&nonce=s7jk5o6pha5u2&user=17964517950155669863&hash=ndn30scuh277r37rdcbdclqb9h49241m");
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
