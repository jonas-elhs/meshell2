import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components

PanelWindow {
    id: root

    required property string path
    required property ShellScreen screen

    property Wallpaper current: wallpaper1
    property Wallpaper next: wallpaper2

    WlrLayershell.layer: WlrLayer.Background
    WlrLayershell.namespace: "meshell-background"

    anchors.left: true
    anchors.bottom: true
    anchors.top: true
    anchors.right: true

    mask: Region {}
    color: "transparent"
    screen: root.screen
    exclusionMode: ExclusionMode.Ignore

    Wallpaper {
        id: wallpaper1
    }
    Wallpaper {
        id: wallpaper2
    }

    Component.onCompleted: updateWallpaper()
    Connections {
        target: root

        function onPathChanged() {
            root.updateWallpaper();
        }
    }
    function updateWallpaper() {
        current.z = 1;
        current.opacity = 0;

        next.source = root.path;
        next.z = 2;
        next.opacity = 1;

        [current, next] = [next, current];
    }

    component Wallpaper: Image {
        id: wallpaper

        anchors.fill: parent

        fillMode: Image.PreserveAspectCrop

        Behavior on opacity {
            CustomNumberAnimation {}
        }
    }
}
