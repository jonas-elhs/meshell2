import Quickshell
import Quickshell.Wayland

PanelWindow {
    required property Bar bar

    WlrLayershell.namespace: "meshell-bar-exclusions"

    anchors.left: true
    anchors.bottom: true
    anchors.top: true

    implicitWidth: bar.barWidth

    color: "transparent"

    margins: bar.margins

    mask: Region {}
}
