import QtQuick
import Quickshell.Hyprland
import qs.io
import qs.components

BarModule {
    id: root

    adjustContentSpacing: false
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

            implicitWidth: diameter
            implicitHeight: focused ? 10 * diameter : diameter
            anchors.horizontalCenter: parent.horizontalCenter

            color: focused ? Color.lighter(Config.accentColor, hover.hovered ? 1.4 : 1) : Color.lighter(Config.foregroundColor, hover.hovered ? 1.4 : 1)
            radius: width / 2

            TapHandler {
                margin: 5
                onTapped: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${workspace.workspaceId} })`)
            }
            HoverHandler {
                id: hover
                margin: 5
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
