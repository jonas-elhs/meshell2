import QtQuick
import Quickshell
import Quickshell.Io
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

        implicitWidth: Math.max(clock.implicitWidth, workspaces.implicitWidth, system.implicitWidth)
        implicitHeight: parent.height

        // Clock
        BarModule {
            id: clock

            width: content.width
            anchors.top: parent.top

            Column {
                anchors.horizontalCenter: parent.horizontalCenter

                MaterialIcon {
                    icon: "schedule"
                    color: "cyan"
                    weight: 500
                    font.pointSize: 15

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: Qt.formatTime(time.date, "hh\nmm")
                    font.pointSize: 13

                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }

        // Workspaces
        BarModule {
            id: workspaces

            property int workspaceCount: Math.max(Hyprland.workspaces.values.length, 5)

            width: content.width
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
                    property int workspaceId: Hyprland.workspaces.values[index]?.id ?? -1
                    property bool focused: (Hyprland.focusedWorkspace?.id ?? -2) == workspaceId

                    color: focused ? "cyan" : hover.hovered ? "lightgrey" : "grey"

                    radius: diameter / 2
                    implicitWidth: diameter
                    implicitHeight: focused ? 10 * diameter : diameter

                    TapHandler {
                        onTapped: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${workspace.workspaceId} })`)
                        margin: 2
                    }

                    HoverHandler {
                        id: hover
                        margin: 2
                    }
                }
            }
        }

        // System Stats
        BarModule {
            id: system

            property int cpu: 0
            property int gpu: 0
            property int ram: 0
            property int disk: 0

            width: content.width
            anchors.bottom: parent.bottom

            padding: 0

            Column {
                anchors.horizontalCenter: parent.horizontalCenter

                MaterialIcon {
                    icon: "memory"
                    color: "cyan"
                    weight: 500
                    font.pointSize: 15

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: system.cpu + "%"
                    font.pointSize: 13

                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Column {
                anchors.horizontalCenter: parent.horizontalCenter

                MaterialIcon {
                    icon: "󰢮"
                    color: "cyan"
                    weight: 500
                    font.pointSize: 15

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: system.gpu + "%"
                    font.pointSize: 13

                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Column {
                anchors.horizontalCenter: parent.horizontalCenter

                MaterialIcon {
                    icon: "memory_alt"
                    color: "cyan"
                    weight: 500
                    font.pointSize: 15

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: system.ram + "%"
                    font.pointSize: 13

                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Column {
                anchors.horizontalCenter: parent.horizontalCenter

                MaterialIcon {
                    icon: "hard_drive"
                    color: "cyan"
                    weight: 500
                    font.pointSize: 15

                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: system.disk + "%"
                    font.pointSize: 13

                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Process {
                id: process

                command: [Quickshell.shellDir + "/scripts/system_stats.py"]
                running: true

                stdout: StdioCollector {
                    waitForEnd: false

                    onTextChanged: {
                        const lines = this.text.trim().split("\n");
                        const values = lines[lines.length - 1].split(";");

                        system.cpu = Number(values[0]);
                        system.gpu = Number(values[1]);
                        system.ram = Number(values[2]);
                        system.disk = Number(values[3]);
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
