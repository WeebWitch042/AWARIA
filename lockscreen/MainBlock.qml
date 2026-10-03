import QtQuick
import QtQuick.Controls

Item {
    id: root

    property alias password: passwordField
    property string statusMessage: ""
    property bool authenticating: false

    signal passwordSubmitted(string password)

    implicitWidth: 420
    implicitHeight: 300

    Column {
        anchors.centerIn: parent
        width: parent.width
        spacing: 16

        Text {
            width: parent.width

            text: "AWARIA"
            color: "#FFFFFF"
            font.pixelSize: 32
            font.bold: true

            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            width: parent.width

            text: "SYSTEM LOCKED"
            color: "#93FF99"
            font.family: "monospace"
            font.pixelSize: 12

            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: passwordField

            width: 320
            height: 44
            anchors.horizontalCenter: parent.horizontalCenter

            enabled: !root.authenticating

            placeholderText: "Password"
            echoMode: TextInput.Password

            color: "#FFFFFF"
            placeholderTextColor: "#A78DB4"

            background: Rectangle {
                color: "#42244A"
                radius: 6

                border.width: 1
                border.color: passwordField.activeFocus
                    ? "#CC30DB"
                    : "#4B3154"
            }

            Keys.onReturnPressed: {
                root.passwordSubmitted(text)
            }

            Keys.onEnterPressed: {
                root.passwordSubmitted(text)
            }
        }

        Button {
            width: 320
            height: 44
            anchors.horizontalCenter: parent.horizontalCenter

            enabled: !root.authenticating

            text: "UNLOCK"

            onClicked: {
                root.passwordSubmitted(passwordField.text)
            }

            contentItem: Text {
                text: parent.text
                color: "#FFFFFF"

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            background: Rectangle {
                color: parent.hovered
                    ? "#BD34C8"
                    : "#4B3154"

                radius: 6
            }
        }

        Text {
            width: parent.width

            text: root.statusMessage
            color: "#CB5A3C"
            font.pixelSize: 12

            horizontalAlignment: Text.AlignHCenter
            visible: text.length > 0
        }
    }
}