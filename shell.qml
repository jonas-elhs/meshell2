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

    IpcHandler {
        target: "shell"

        function powerMenu() {
            ShellState.showPowerMenu = !ShellState.showPowerMenu;
        }

        function wallpaper(path: string) {
            ShellState.wallpaperPath = path;
        }

        function lock() {
            ShellState.locked = true;
        }
    }

    Lockscreen {
        barWidth: bar.barWidth
    }

    Background {}

    Bar {
        id: bar
    }
    BarExclusions {
        bar: bar
    }
}
