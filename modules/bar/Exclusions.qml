import Quickshell
import Quickshell.Wayland

PanelWindow {
    required property Bar bar

    WlrLayershell.namespace: "meshell-bar-exclusions"

    implicitWidth: bar.barWidth

    margins: bar.margins
    anchors.top: true
    anchors.left: true
    anchors.bottom: true

    mask: Region {}
    color: "transparent"
}
