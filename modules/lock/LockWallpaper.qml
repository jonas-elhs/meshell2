import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import qs.io
import qs.components

PanelWindow {
    id: root

    required property int barWidth

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    WlrLayershell.namespace: "meshell-lock-wallpaper"

    color: "transparent"
    mask: Region {}
    exclusionMode: ExclusionMode.Ignore

    ClippingRectangle {
        id: mask

        anchors.verticalCenter: parent.verticalCenter

        x: ShellState.locked ? 0 : 20
        opacity: ShellState.locked ? 1 : 0
        implicitWidth: ShellState.locked ? root.screen.width : root.barWidth
        implicitHeight: ShellState.locked ? root.screen.height : 0

        Image {
            x: -mask.x
            y: -mask.y
            width: root.width
            height: root.height

            source: ShellState.wallpaperPath
            fillMode: Image.PreserveAspectCrop
        }

        CustomNumberBehavior on x {}
        CustomNumberBehavior on opacity {}
        CustomNumberBehavior on implicitWidth {}
        CustomNumberBehavior on implicitHeight {}
    }
}
