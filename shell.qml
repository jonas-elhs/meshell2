import Quickshell
import Quickshell.Io
import qs.modules.background

ShellRoot {
    id: root

    property string wallpaperPath: "/home/jonas/wallpapers/moon.png"

    IpcHandler {
        target: "wallpaper"

        function set(path: string) {
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
            }
        }
    }
}
