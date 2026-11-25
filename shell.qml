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
        id: ipc

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
    GlobalShortcut {
        appid: "meshell"
        name: "powerMenu"
        description: "Toggle power menu"
        onPressed: ipc.powerMenu()
    }
    GlobalShortcut {
        appid: "meshell"
        name: "lock"
        description: "Lock screen"
        onPressed: ipc.lock()
    }

    Lockscreen {}

    Background {}

    Bar {}
    BarExclusions {}
}
