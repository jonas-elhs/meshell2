import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components

PanelWindow {
    id: root

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "meshell-bar"

    implicitWidth: content.implicitWidth

    anchors.left: true
    anchors.bottom: true
    anchors.top: true

    margins.left: 20
    margins.bottom: 20
    margins.top: 20

    color: "transparent"

    Item {
        id: content

        implicitWidth: Math.max(clock.implicitWidth, workspaces.implicitWidth, system.implicitWidth)
        implicitHeight: parent.height

        Clock {
            id: clock

            width: content.width
            anchors.top: parent.top
        }

        Workspaces {
            id: workspaces

            width: content.width
            anchors.verticalCenter: parent.verticalCenter
        }

        SystemStats {
            id: system

            width: content.width
            anchors.bottom: parent.bottom
        }
    }
}
