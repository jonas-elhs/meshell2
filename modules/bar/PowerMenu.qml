import QtQuick
import Quickshell
import qs.components

BarModule {
    PowerButton {
        icon: "stop_circle"
        command: ["systemctl", "suspend"]
    }
    PowerButton {
        icon: "save"
        command: ["systemctl", "hibernate"]
    }
    PowerButton {
        icon: "power_settings_new"
        command: ["systemctl", "poweroff"]
    }
    PowerButton {
        icon: "cached"
        command: ["systemctl", "reboot"]
    }
    PowerButton {
        icon: "lock"
        command: ["loginctl", "lock-session"]
    }

    component PowerButton: Rectangle {
        id: button

        required property string icon
        required property list<string> command

        function execute() {
            Quickshell.execDetached(command);
        }

        width: 100
        height: width
        color: "transparent"
        radius: 7
        border.width: 2
        border.color: hover.hovered ? "cyan" : "transparent"

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
        }
    }
}
