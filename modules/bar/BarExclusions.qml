import Quickshell
import Quickshell.Wayland
import qs.io

PanelWindow {
    required property Bar bar

    WlrLayershell.namespace: "meshell-bar-exclusions"

    implicitWidth: ShellState.barWidth

    margins.left: Config.spacing
    anchors.top: true
    anchors.left: true
    anchors.bottom: true

    mask: Region {}
    color: "transparent"
}
