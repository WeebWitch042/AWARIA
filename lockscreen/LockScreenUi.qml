import QtQuick

Item {
    id: root

    property string statusMessage: ""
    property bool authenticating: false

    signal clearPassword()

    Rectangle {
        anchors.fill: parent
        color: "#0E1029"
    }

    Connections {
        target: authenticator

        function onSucceeded() {
            root.authenticating = false
            Qt.quit()
        }

        function onFailed(kind) {
            if (kind !== 0)
                return

            root.authenticating = false
            root.statusMessage = "Authentication failed"
            mainBlock.password.clear()
            mainBlock.password.forceActiveFocus()
            authenticator.startAuthenticating()
        }

        function onInfoMessageChanged() {
            root.statusMessage = authenticator.infoMessage
        }

        function onErrorMessageChanged() {
            root.statusMessage = authenticator.errorMessage
        }

        function onPromptChanged() {
            root.statusMessage = authenticator.prompt
        }
    }

    onClearPassword: {
        mainBlock.password.clear()
        mainBlock.password.forceActiveFocus()
    }

    MainBlock {
        id: mainBlock
        anchors.centerIn: parent
        statusMessage: root.statusMessage
        authenticating: root.authenticating

        onPasswordSubmitted: function(password) {
            if (root.authenticating || password.length === 0)
                return

            root.authenticating = true
            root.statusMessage = ""
            authenticator.respond(password)
        }
    }

    Component.onCompleted: {
        authenticator.startAuthenticating()
        mainBlock.password.forceActiveFocus()
    }
}
