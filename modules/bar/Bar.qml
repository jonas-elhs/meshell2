import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.components

PanelWindow {
    id: root

    property int barWidth: 40

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "meshell-bar"

    anchors.left: true
    anchors.bottom: true
    anchors.right: true
    anchors.top: true

    mask: Region {
        regions: [...moduleRegions.instances]
    }
    Variants {
        id: moduleRegions
        model: content.children

        Region {
            required property Item modelData
            item: modelData
        }
    }
    exclusionMode: ExclusionMode.Ignore

    margins.left: 20
    margins.bottom: 20
    margins.top: 20

    color: "transparent"

    Item {
        id: content

        implicitWidth: root.barWidth
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
