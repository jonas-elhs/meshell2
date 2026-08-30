import QtQuick
import Quickshell.Hyprland
import qs.components

BarModule {
    id: root

    onScrolled: event => {
        if (event.angleDelta.y > 0)
            Hyprland.dispatch("hl.dsp.focus({ workspace = 'e-1' })");
        else if (event.angleDelta.y < 0)
            Hyprland.dispatch("hl.dsp.focus({ workspace = 'e+1' })");
    }

    Repeater {
        model: Hyprland.workspaces.values.length

        Rectangle {
            id: workspace

            required property int index
            property int diameter: 10
            property int workspaceId: Hyprland.workspaces.values[index]?.id ?? -1
            property bool focused: (Hyprland.focusedWorkspace?.id ?? -2) == workspaceId

            color: focused ? (hover.hovered ? "lightcyan" : "cyan") : hover.hovered ? "lightgrey" : "grey"

            radius: diameter / 2
            implicitWidth: diameter
            implicitHeight: focused ? 10 * diameter : diameter
            anchors.horizontalCenter: parent.horizontalCenter

            TapHandler {
                onTapped: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${workspace.workspaceId} })`)
                margin: 2
            }
            HoverHandler {
                id: hover
                margin: 2
            }

            Behavior on color {
                CustomColorAnimation {}
            }
            Behavior on implicitHeight {
                CustomNumberAnimation {}
            }
        }
    }
}
