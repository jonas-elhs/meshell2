import QtQuick
import Quickshell
import qs.components

// TODO: slightly too large spacing between buttons
BarModule {
    width: 110

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

    component PowerButton: BarItem {
        id: button

        required property list<string> command

        function execute() {
            Quickshell.execDetached(command);
        }

        iconSize: 50
        iconWeight: 700
    }
}
