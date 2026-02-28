import QtQuick
import Quickshell
import Quickshell.Wayland

ShellRoot {
    id: root

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

                    source: "/home/jonas/wallpapers/moon.png"
                    fillMode: Image.PreserveAspectCrop
                }
            }
        }
    }
}
