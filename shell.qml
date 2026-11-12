pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import qs.modules
import qs.modules.bar

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
    }

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
