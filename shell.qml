import Quickshell
import Quickshell.Io
import qs.modules
import qs.modules.bar

ShellRoot {
    id: root

    property string wallpaperPath: "/home/jonas/wallpapers/moon.png"
    property bool centerWorkspace: true

    IpcHandler {
        target: "wallpaper"

        function set(path: string) {
            root.wallpaperPath = path;
        }
    }

    IpcHandler {
        target: "test"

        function toggle() {
            root.centerWorkspace = !root.centerWorkspace;
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
                cw: root.centerWorkspace
            }

            Exclusions {
                bar: bar
            }
        }
    }
}
