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

            property int workspaceCount: 5

            anchors.verticalCenter: parent.verticalCenter

            Repeater {
                model: workspaces.workspaceCount

                Rectangle {
                    required property int index
                    property int diameter: 10
                    property bool focused: Hyprland.focusedWorkspace.id == Hyprland.workspaces.values[index]?.id

                    color: focused ? "cyan" : "grey"

                    radius: diameter / 2
                    implicitWidth: diameter
                    implicitHeight: focused ? 100 : diameter
                }
            }
        }
    }

    SystemClock {
        id: time
        precision: SystemClock.Minutes
    }
}
