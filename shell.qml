import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

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

            PanelWindow {
                id: background

                anchors.left: true
                anchors.bottom: true
                anchors.top: true
                anchors.right: true

                mask: Region {}
                color: "transparent"
                screen: scope.modelData
                WlrLayershell.layer: WlrLayer.Background

                Image {
                    id: wallpaper

                    anchors.fill: parent

                    source: root.wallpaperPath
                    fillMode: Image.PreserveAspectCrop
                }
            }
        }
    }
}
