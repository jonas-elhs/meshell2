import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

PanelWindow {
    id: root

    required property string path

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
    WlrLayershell.namespace: "meshell-background"

    Component.onCompleted: updateWallpaper()
    Connections {
        target: root

        function onPathChanged() {
            root.updateWallpaper();
        }
    }

    function updateWallpaper() {
        // Update wallpaper path
        buffer.source = root.path;

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
