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

                property Wallpaper current: wallpaper1
                property Wallpaper buffer: wallpaper2

                anchors.left: true
                anchors.bottom: true
                anchors.top: true
                anchors.right: true

                mask: Region {}
                color: "transparent"
                screen: scope.modelData
                WlrLayershell.layer: WlrLayer.Background

                Component.onCompleted: updateWallpaper()
                Connections {
                    target: root

                    function onWallpaperPathChanged() {
                        background.updateWallpaper();
                    }
                }

                function updateWallpaper() {
                    // Update wallpaper path
                    buffer.source = root.wallpaperPath;

                    // Position buffer above current
                    current.z = 1;
                    buffer.z = 2;

                    // Fade buffer in and current out
                    current.opacity = 0;
                    buffer.opacity = 1;

                    // Swap buffer and current
                    [current, buffer] = [buffer, current];
                }

                Wallpaper {
                    id: wallpaper1
                }
                Wallpaper {
                    id: wallpaper2
                }
            }
        }
    }

    component Wallpaper: Image {
        id: wallpaper

        anchors.fill: parent

        fillMode: Image.PreserveAspectCrop

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }
    }
}
