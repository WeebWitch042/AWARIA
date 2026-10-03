import QtQuick
import org.kde.kwin.decoration

Decoration {
    id: root

    property real pixelWidth: 1.5

    property color colorPurple: "#CC30DB"
    property color colorCyan: "#13ECFF"
    property color colorPink: "#42244A"
    property color colorMagenta: "#4B3154"
    property color colorWhite: "#0E1029"
    property color colorGray: "#2D1839"

    readonly property real buttonSize: pixelWidth * 10

    DecorationOptions {
        id: options
        deco: decoration
    }

    Rectangle {
        id: shadow

        visible: !decoration.client.maximized && decoration.client.active
        width: background.width
        height: background.height

        anchors.left: background.left
        anchors.top: background.top
        anchors.leftMargin: root.padding.right
        anchors.topMargin: root.padding.bottom

        color: root.colorPurple
        opacity: 0.3
        z: -1
    }

    Rectangle {
        id: background

        color: decoration.client.active
            ? root.colorCyan
            : root.colorGray

        border.width: root.pixelWidth
        border.color: root.colorPurple

        anchors.fill: parent
        anchors.leftMargin: root.padding.left
        anchors.rightMargin: root.padding.right
        anchors.topMargin: root.padding.top
        anchors.bottomMargin: root.padding.bottom
    }

    Rectangle {
        id: titleRow

        color: decoration.client.active
            ? root.colorPink
            : root.colorGray

        border.width: root.pixelWidth
        border.color: root.colorPurple

        height: root.pixelWidth * 15

        anchors {
            left: background.left
            right: background.right
            top: background.top
            topMargin: root.pixelWidth * 3
            leftMargin: root.pixelWidth * 3
            rightMargin: root.pixelWidth * 3
        }

        ButtonGroup {
            id: leftButtonGroup

            spacing: root.pixelWidth * 2
            explicitSpacer: root.buttonSize

            menuButton: menuButtonComponent
            appMenuButton: appMenuButtonComponent
            minimizeButton: minimizeButtonComponent
            maximizeButton: maximizeButtonComponent
            keepBelowButton: keepBelowButtonComponent
            keepAboveButton: keepAboveButtonComponent
            helpButton: helpButtonComponent
            shadeButton: shadeButtonComponent
            allDesktopsButton: stickyButtonComponent
            closeButton: closeButtonComponent

            buttons: options.titleButtonsLeft

            anchors {
                top: parent.top
                topMargin: root.pixelWidth * 2.5
                left: parent.left
                leftMargin: root.pixelWidth * 3
            }
        }

        Text {
            id: caption

            textFormat: Text.PlainText

            anchors {
                left: leftButtonGroup.right
                right: rightButtonGroup.left
                leftMargin: root.pixelWidth * 3
                rightMargin: root.pixelWidth * 3
                verticalCenter: parent.verticalCenter
            }

            color: root.colorPurple
            text: decoration.client.caption
            font: options.titleFont
            elide: Text.ElideMiddle
            renderType: Text.NativeRendering
        }

        ButtonGroup {
            id: rightButtonGroup

            spacing: root.pixelWidth * 2
            explicitSpacer: root.buttonSize

            menuButton: menuButtonComponent
            appMenuButton: appMenuButtonComponent
            minimizeButton: minimizeButtonComponent
            maximizeButton: maximizeButtonComponent
            keepBelowButton: keepBelowButtonComponent
            keepAboveButton: keepAboveButtonComponent
            helpButton: helpButtonComponent
            shadeButton: shadeButtonComponent
            allDesktopsButton: stickyButtonComponent
            closeButton: closeButtonComponent

            buttons: options.titleButtonsRight

            anchors {
                top: parent.top
                topMargin: root.pixelWidth * 2.5
                right: parent.right
                rightMargin: root.pixelWidth * 3
            }
        }

        Component.onCompleted: {
            decoration.installTitleItem(this)
        }
    }

    Rectangle {
        id: contentBackground

        color: root.colorWhite
        border.width: root.pixelWidth
        border.color: root.colorPurple

        anchors {
            fill: background
            leftMargin: root.pixelWidth * 3
            rightMargin: root.pixelWidth * 3
            topMargin: root.pixelWidth * 5 + titleRow.height
            bottomMargin: root.pixelWidth * 7
        }
    }

    Component {
        id: menuButtonComponent

        PixelButton {
            buttonType: DecorationOptions.DecorationButtonMenu
            size: root.buttonSize
            mainColor: root.colorPurple
        }
    }

    Component {
        id: appMenuButtonComponent

        PixelButton {
            buttonType: DecorationOptions.DecorationButtonApplicationMenu
            size: root.buttonSize
            mainColor: root.colorPurple
        }
    }

    Component {
        id: maximizeButtonComponent

        PixelButton {
            objectName: "maximizeButton"
            buttonType: DecorationOptions.DecorationButtonMaximizeRestore
            size: root.buttonSize
            mainColor: root.colorPurple
        }
    }

    Component {
        id: minimizeButtonComponent

        PixelButton {
            buttonType: DecorationOptions.DecorationButtonMinimize
            size: root.buttonSize
            mainColor: root.colorPurple
        }
    }

    Component {
        id: keepBelowButtonComponent

        PixelButton {
            buttonType: DecorationOptions.DecorationButtonKeepBelow
            size: root.buttonSize
            mainColor: root.colorPurple
        }
    }

    Component {
        id: keepAboveButtonComponent

        PixelButton {
            buttonType: DecorationOptions.DecorationButtonKeepAbove
            size: root.buttonSize
            mainColor: root.colorPurple
        }
    }

    Component {
        id: helpButtonComponent

        PixelButton {
            buttonType: DecorationOptions.DecorationButtonQuickHelp
            size: root.buttonSize
            mainColor: root.colorPurple
        }
    }

    Component {
        id: shadeButtonComponent

        PixelButton {
            buttonType: DecorationOptions.DecorationButtonShade
            size: root.buttonSize
            mainColor: root.colorPurple
        }
    }

    Component {
        id: stickyButtonComponent

        PixelButton {
            buttonType: DecorationOptions.DecorationButtonOnAllDesktops
            size: root.buttonSize
            mainColor: root.colorPurple
        }
    }

    Component {
        id: closeButtonComponent

        PixelButton {
            buttonType: DecorationOptions.DecorationButtonClose
            size: root.buttonSize
            mainColor: root.colorPurple
        }
    }

    function updatePadding() {
        if (!decoration.client.maximized) {
            padding.setBorders(2 * pixelWidth)
        } else {
            padding.setBorders(0)
        }
    }

    function setupBorders() {
        let pw = decoration.readConfig("pixelWidth", 15)

        if (pw)
            root.pixelWidth = pw / 10

        borders.setBorders(4 * pixelWidth)
        borders.bottom = 8 * pixelWidth
        borders.setTitle(titleRow.height + 6 * pixelWidth)

        maximizedBorders.setBorders(4 * pixelWidth)
        maximizedBorders.bottom = 8 * pixelWidth
        maximizedBorders.setTitle(titleRow.height + 6 * pixelWidth)

        extendedBorders.setBorders(4 * pixelWidth)
        extendedBorders.bottom = 8 * pixelWidth
        extendedBorders.setTitle(titleRow.height + 6 * pixelWidth)

        updatePadding()
    }

    function setupColors() {
        root.colorPurple =
            decoration.readConfig(
                "colorPurple",
                Qt.color("#CC30DB")
            )

        root.colorCyan =
            decoration.readConfig(
                "colorCyan",
                Qt.color("#13ECFF")
            )

        root.colorPink =
            decoration.readConfig(
                "colorPink",
                Qt.color("#42244A")
            )

        root.colorMagenta =
            decoration.readConfig(
                "colorMagenta",
                Qt.color("#4B3154")
            )

        root.colorGray =
            decoration.readConfig(
                "colorGray",
                Qt.color("#2D1839")
            )
    }

    Connections {
        target: decoration.client

        function onMaximizedChanged() {
            root.updatePadding()
        }
    }

    Connections {
        target: decoration

        function onConfigChanged() {
            root.setupBorders()
            root.setupColors()
        }
    }

    Component.onCompleted: {
        setupBorders()
        setupColors()
    }
}