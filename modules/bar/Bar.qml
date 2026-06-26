import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
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

        implicitWidth: clock.implicitWidth
        implicitHeight: parent.height

        // Clock
        BarModule {
            id: clock

            anchors.top: parent.top

            Text {
                id: text
                text: Qt.formatTime(time.date, "hh\nmm")
            }
        }

        // Workspaces
        BarModule {
            id: workspaces

            property int workspaceCount: Math.max(Hyprland.workspaces.values.length, 5)

            anchors.verticalCenter: parent.verticalCenter

            onScrolled: event => {
                if (event.angleDelta.y > 0)
                    Hyprland.dispatch("hl.dsp.focus({ workspace = 'e-1' })");
                else if (event.angleDelta.y < 0)
                    Hyprland.dispatch("hl.dsp.focus({ workspace = 'e+1' })");
            }

            Repeater {
                model: workspaces.workspaceCount

                Rectangle {
                    id: workspace

                    required property int index
                    property int diameter: 10
                    property int workspaceId: Hyprland.workspaces.values[index]?.id
                    property bool focused: Hyprland.focusedWorkspace.id == workspaceId

                    color: focused ? "cyan" : "grey"

                    radius: diameter / 2
                    implicitWidth: diameter
                    implicitHeight: focused ? 100 : diameter

                    TapHandler {
                        onTapped: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${workspace.workspaceId} })`)
                    }
                }
            }
        }
    }

    SystemClock {
        id: time
        precision: SystemClock.Minutes
    }
}
