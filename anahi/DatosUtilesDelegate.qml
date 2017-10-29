
import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1
import "PhotoViewerCore"
import Backend 1.0

ItemDelegate {
    id: delegate

    //property bool checkable: true
    checkable: true

    Dialog {
        id: dlg
        visible: false
        contentItem: Rectangle {
            height: 400
            color: "lightskyblue"
            implicitWidth: 400
            implicitHeight: 400
            ColumnLayout {
                Text {
                    width: 380
                    color: "navy"
                    text: "Copyright (C) 2017  Diego Ignacio Wald

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/"
                    textFormat: Text.AutoText
                    font.pointSize: 9
                    elide: Text.ElideMiddle
                    Layout.fillWidth: false
                }
            }
        }
    }

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
        case DatosUtilesModel.About:
            return "Info";
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
                    case DatosUtilesModel.About:
                        dlg.visible = true;
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
