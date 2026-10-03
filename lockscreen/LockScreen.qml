import QtQuick
import org.kde.plasma.private.sessions

Item {
    id: root

    property bool viewVisible: false
    property bool suspendToRamSupported: false
    property bool suspendToDiskSupported: false

    signal clearPassword()
    signal notificationRepeated()
    signal suspendToRam()
    signal suspendToDisk()

    implicitWidth: 800
    implicitHeight: 600

    LockScreenUi {
        id: lockScreenUi
        anchors.fill: parent
    }

    onClearPassword: lockScreenUi.clearPassword()
}