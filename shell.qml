pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import qs.modules
import qs.modules.bar

ShellRoot {
    id: root

    property string wallpaperPath: "/home/jonas/wallpapers/moon.png"

    property Bar b

    IpcHandler {
        target: "wallpaper"

        function set(path: string) {
            root.wallpaperPath = path;
        }
    }
    IpcHandler {
        target: "power"

        function toggle() {
            b.togglePower();
        }
    }

    Variants {
        model: Quickshell.screens

        Scope {
            id: scope
            property ShellScreen modelData

            Component.onCompleted: root.b = bar

            Background {
                path: root.wallpaperPath
                screen: scope.modelData
            }

            Bar {
                id: bar
            }

            Exclusions {
                bar: bar
            }
        }
    }
}
