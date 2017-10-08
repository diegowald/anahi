
import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1
import "PhotoViewerCore"
import Backend 1.0

ItemDelegate {
    id: delegate

    //property bool checkable: true
    checkable: true


    function buttonLabel() {
        switch (tipo)
        {
        case DatosUtilesModel.Map:
            return "Mapa";
        case DatosUtilesModel.Telephone:
            return "Llamar";
        case DatosUtilesModel.WhatsApp:
            return "WhatsApp";
        case DatosUtilesModel.Web:
            return "Web";
        }
        return "";
    }
    
    contentItem: ColumnLayout {
        spacing: 10

        Label {
            text: fullName
            font.bold: true
            elide: Text.ElideRight
            Layout.fillWidth: true
        }
        
        GridLayout {
            id: grid
            visible: false

            columns: 3
            rowSpacing: 10
            columnSpacing: 10

            Label {
                text: "Direccion:"
                Layout.leftMargin: 60
            }

            Label {
                text: address
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }


            Button {
                Layout.rowSpan: 3
                id: buttonAction
                label: buttonLabel()
                onClicked: {
                    switch (tipo)
                    {
                    case DatosUtilesModel.Map:
                        engine.launchMapNavigation(number);
                        break;
                    case DatosUtilesModel.Telephone:
                        engine.call(number);
                        break;
                    case DatosUtilesModel.WhatsApp:
                        engine.sendWhatsApp(number);
                        break;
                    case DatosUtilesModel.Web:
                        engine.launchURL(number);
                        break;
                    }
                }
            }

            Label {
                text: "Ciudad:"
                Layout.leftMargin: 60
            }

            Label {
                text: city
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            Label {
                text: "Telefono:"
                Layout.leftMargin: 60
            }

            Label {
                text: number
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }


    }
    
    states: [
        State {
            name: "expanded"
            when: delegate.checked
            
            PropertyChanges {
                target: grid
                visible: true
            }

            PropertyChanges {
                target: buttonAction
                visible:true
            }
        }
    ]
}
