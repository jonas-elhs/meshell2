import QtQuick
import Quickshell
import qs.components

BarModule {
    id: root

    Component.onCompleted: shutdown.forceActiveFocus()

    PowerButton {
        id: suspend

        icon: "bedtime"
        command: ["systemctl", "suspend"]

        KeyNavigation.up: lock
        KeyNavigation.down: hibernate
    }
    PowerButton {
        id: hibernate

        icon: "save"
        command: ["systemctl", "hibernate"]

        KeyNavigation.up: suspend
        KeyNavigation.down: shutdown
    }
    PowerButton {
        id: shutdown

        icon: "power_settings_new"
        command: ["systemctl", "poweroff"]

        KeyNavigation.up: hibernate
        KeyNavigation.down: reboot
    }
    PowerButton {
        id: reboot

        icon: "restart_alt"
        command: ["systemctl", "reboot"]

        KeyNavigation.up: shutdown
        KeyNavigation.down: lock
    }
    PowerButton {
        id: lock

        icon: "lock"
        command: ["loginctl", "lock-session"]

        KeyNavigation.up: reboot
        KeyNavigation.down: suspend
    }

    component PowerButton: Rectangle {
        id: button

        required property string icon
        required property list<string> command

        function execute() {
            console.log(command);
            // Quickshell.execDetached(command);
        }

        Keys.onEnterPressed: execute()
        Keys.onEscapePressed: root.visible = false
        Keys.onPressed: event => {
            if (event.key == Qt.Key_J) {
                KeyNavigation.down.forceActiveFocus();
                event.accepted = true;
            } else if (event.key == Qt.Key_K) {
                KeyNavigation.up.forceActiveFocus();
                event.accepted = true;
            }
        }

        implicitWidth: 100
        implicitHeight: implicitWidth
        color: "transparent"
        radius: 7
        border.width: 2
        border.color: activeFocus ? "cyan" : "transparent"

        MaterialIcon {
            icon: button.icon
            weight: 700
            font.pointSize: 50
            anchors.centerIn: parent
        }

        TapHandler {
            onTapped: button.execute()
        }
        HoverHandler {
            id: hover
            onHoveredChanged: button.forceActiveFocus()
        }
    }
}
