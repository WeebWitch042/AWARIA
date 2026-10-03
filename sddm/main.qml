import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root

    readonly property color surface: "#2D1839"
    readonly property color surface2: "#42244A"
    readonly property color buttonColor: "#4B3154"
    readonly property color purple: "#CC30DB"
    readonly property color purpleHover: "#BD34C8"
    readonly property color white: "#FFFFFF"
    readonly property color muted: "#A78DB4"
    readonly property color toxicGreen: "#93FF99"
    readonly property color negative: "#CB5A3C"

    property string statusText: "> authentication ready"
    property bool loginBusy: false

    function submitLogin() {
        if (loginBusy || usernameField.text.length === 0 || passwordField.text.length === 0)
            return

        loginBusy = true
        statusText = "> authenticating..."
        sddm.login(usernameField.text, passwordField.text, sessionModel.lastIndex)
    }

    Image {
        anchors.fill: parent
        source: "SM_wallp.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        width: 420
        height: 500
        anchors.centerIn: parent
        color: root.surface
        radius: 12
        border.width: 1
        border.color: root.purple

        Column {
            anchors.centerIn: parent
            spacing: 16

            Text {
                text: "AWARIA"
                color: root.white
                font.pixelSize: 32
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
            }

            TextField {
                id: usernameField
                width: 320
                placeholderText: "Username"
                text: userModel.lastUser || ""
                color: root.white
                placeholderTextColor: root.muted
                enabled: !root.loginBusy

                background: Rectangle {
                    color: root.surface2
                    border.color: usernameField.activeFocus ? root.purple : root.buttonColor
                    border.width: 1
                    radius: 6
                }

                Keys.onReturnPressed: passwordField.forceActiveFocus()
                Keys.onEnterPressed: passwordField.forceActiveFocus()
            }

            TextField {
                id: passwordField
                width: 320
                placeholderText: "Password"
                echoMode: TextInput.Password
                color: root.white
                placeholderTextColor: root.muted
                enabled: !root.loginBusy

                background: Rectangle {
                    color: root.surface2
                    border.color: passwordField.activeFocus ? root.purple : root.buttonColor
                    border.width: 1
                    radius: 6
                }

                Keys.onReturnPressed: root.submitLogin()
                Keys.onEnterPressed: root.submitLogin()
            }

            Button {
                width: 320
                enabled: !root.loginBusy
                text: root.loginBusy ? "LOGGING IN..." : "LOG IN"
                onClicked: root.submitLogin()

                contentItem: Text {
                    text: parent.text
                    color: root.white
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                background: Rectangle {
                    color: parent.hovered ? root.purpleHover : root.buttonColor
                    radius: 6
                }
            }

            Text {
                width: 320
                text: root.statusText
                color: root.statusText.indexOf("failed") !== -1 ? root.negative : root.toxicGreen
                font.family: "monospace"
                font.pixelSize: 12
                wrapMode: Text.Wrap
            }
        }
    }

    Connections {
        target: sddm

        function onLoginFailed() {
            root.loginBusy = false
            root.statusText = "> authentication failed"
            passwordField.clear()
            passwordField.forceActiveFocus()
        }

        function onLoginSucceeded() {
            root.statusText = "> login successful"
        }
    }

    Component.onCompleted: {
        if (usernameField.text.length > 0)
            passwordField.forceActiveFocus()
        else
            usernameField.forceActiveFocus()
    }
}
