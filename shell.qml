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
    property string wallpaperPath: "/home/jonas/wallpapers/moon.png"

    IpcHandler {
        target: "shell"

        function togglePowerMenu() {
            root.showPowerMenu = !root.showPowerMenu;
        }

        function setWallpaper(path: string) {
            root.wallpaperPath = path;
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
                path: root.wallpaperPath
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
