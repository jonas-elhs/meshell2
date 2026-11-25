pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import qs.io
import qs.modules
import qs.modules.bar
import qs.modules.lock

ShellRoot {
    id: root

    property bool showPowerMenu: false

    IpcHandler {
        target: "shell"

        function powerMenu() {
            root.showPowerMenu = !root.showPowerMenu;
        }

        function wallpaper(path: string) {
            ShellState.wallpaperPath = path;
        }

        function lock() {
            ShellState.locked = true;
        }
    }
    GlobalShortcut {
        name: "power"
        appid: "meshell"
        description: "Toggle power menu"
        onPressed: root.showPowerMenu = !root.showPowerMenu
    }

    Lock {}

    Variants {
        model: Quickshell.screens

        Scope {
            id: scope

            property ShellScreen modelData

            Background {
                screen: scope.modelData
            }

            Bar {
                id: bar
                showPowerMenu: root.showPowerMenu
                onPowerMenuToggleRequested: root.showPowerMenu = !root.showPowerMenu
            }

            Exclusions {
                bar: bar
            }
        }
    }
}
