
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

    function direccionVisible() {
        switch (tipo)
        {
        case DatosUtilesModel.Map:
            return true;
        }
        return false;
    }

    function buttonVisble() {
        if (engine.isCurrentDateInRange(visibleDesde, visibleHasta))
            return true;
        else
            return false;
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
            rowSpacing: 2
            columnSpacing: 2

            Label {
                x: 2
                text: "Dirección:"
                Layout.leftMargin: 5
                visible: direccionVisible()
            }

            Label {
                text: address
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
                visible: direccionVisible()
            }


            Button {
                Layout.rowSpan: 3
                id: buttonAction
                label: buttonLabel()
                visibilidad: buttonVisble()
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
                x: 2
                text: "Ciudad:"
                Layout.leftMargin: 5
                visible: direccionVisible()
            }

            Label {
                text: city
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
                visible: direccionVisible()
            }

            /*Label {
                text: "Telefono:"
                Layout.leftMargin: 60
            }

            Label {
                text: number
                font.bold: true
                elide: Text.ElideRight
                Layout.fillWidth: true
            }*/
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
