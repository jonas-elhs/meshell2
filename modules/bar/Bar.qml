import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.components

PanelWindow {
    id: root

    property int barWidth

    function togglePower() {
        power.visible = !power.visible;
        workspaces.visible = !workspaces.visible;
        grab.active = true;
    }

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.namespace: "meshell-bar"
    WlrLayershell.keyboardFocus: power.visible ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None

    Component.onCompleted: root.barWidth = Math.max(clock.implicitWidth, workspaces.implicitWidth, system.implicitWidth)

    anchors.left: true
    anchors.bottom: true
    anchors.right: true
    anchors.top: true

    margins.left: 20
    margins.bottom: 20
    margins.top: 20

    color: "transparent"

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

    HyprlandFocusGrab {
        id: grab
        windows: [root]
        // onCleared: {
        //     console.log("cleared");
        //     workspaces.visible = true;
        //     power.visible = false;
        // }
    }

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

        PowerMenu {
            id: power

            visible: false
            anchors.verticalCenter: parent.verticalCenter
        }

        SystemStats {
            id: system

            width: content.width
            anchors.bottom: parent.bottom
        }
    }
}
