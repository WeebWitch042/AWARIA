import QtQuick
import org.kde.kwin.decoration

DecorationButton {
    id: root

    property real size: 15
    property color mainColor: "#CC30DB"

    width: size
    height: size

    Rectangle {
        anchors.fill: parent

        color: root.pressed
            ? "#0E1029"
            : root.hovered
                ? "#13ECFF"
                : "transparent"

        border.width: root.hovered || root.pressed ? 1 : 0
        border.color: root.mainColor

        Text {
            anchors.centerIn: parent

            text: {
                switch (root.buttonType) {
                case DecorationOptions.DecorationButtonClose:
                    return "×"

                case DecorationOptions.DecorationButtonMinimize:
                    return "−"

                case DecorationOptions.DecorationButtonMaximizeRestore:
                    return decoration.client.maximized ? "❐" : "□"

                case DecorationOptions.DecorationButtonMenu:
                case DecorationOptions.DecorationButtonApplicationMenu:
                    return "≡"

                case DecorationOptions.DecorationButtonKeepAbove:
                    return "↑"

                case DecorationOptions.DecorationButtonKeepBelow:
                    return "↓"

                case DecorationOptions.DecorationButtonShade:
                    return "▾"

                case DecorationOptions.DecorationButtonOnAllDesktops:
                    return "◆"

                case DecorationOptions.DecorationButtonQuickHelp:
                    return "?"

                default:
                    return "·"
                }
            }

            color: root.hovered
                ? "#0E1029"
                : root.mainColor

            font.pixelSize: root.size * 0.7
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}