pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.components

BarModule {
    id: root

    signal closeRequested

    width: 120

    Component.onCompleted: shutdown.forceActiveFocus()

    PowerButton {
        id: suspend

        icon: "stop_circle"
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

        icon: "cached"
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

    component PowerButton: BarItem {
        id: button

        required property list<string> command

        function trigger() {
            Quickshell.execDetached(command);
        }

        onClicked: trigger()

        iconSize: 60
        iconColor: Config.foregroundColor
        iconWeight: 600
        focusable: true

        Keys.onEnterPressed: event => {
            trigger();
            event.accepted = true;
        }
        Keys.onReturnPressed: event => {
            trigger();
            event.accepted = true;
        }
        Keys.onEscapePressed: event => {
            root.closeRequested();
            event.accepted = true;
        }
        Keys.onPressed: event => {
            if (event.key == Qt.Key_J) {
                KeyNavigation.down.forceActiveFocus();
                event.accepted = true;
            } else if (event.key == Qt.Key_K) {
                KeyNavigation.up.forceActiveFocus();
                event.accepted = true;
            }
        }
    }
}
