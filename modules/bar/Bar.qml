import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.io
import qs.components

PanelWindow {
    id: root

    readonly property int barWidth: 40

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

    color: "transparent"

    HyprlandFocusGrab {
        active: ShellState.showPowerMenu
        windows: [root]

        onCleared: ShellState.showPowerMenu = false
    }

    Item {
        id: content

        implicitWidth: root.barWidth

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        anchors.topMargin: Config.spacing
        anchors.leftMargin: Config.spacing
        anchors.bottomMargin: Config.spacing

        Time {
            id: time

            width: content.width
            anchors.top: parent.top
        }

        BarMultiModule {
            anchors.verticalCenter: parent.verticalCenter

            MultiModuleComponent {
                Workspaces {
                    styled: false
                    width: content.width
                }
            }

            MultiModuleComponent {
                condition: ShellState.showPowerMenu

                PowerMenu {
                    styled: false
                }
            }

            MultiModuleComponent {
                condition: ShellState.locked

                Locked {
                    styled: false
                    screen: root.screen
                }
            }
        }

        SystemStats {
            id: system

            width: content.width
            anchors.bottom: power.top
            anchors.bottomMargin: Config.spacing
        }
        PowerButton {
            id: power

            width: content.width
            anchors.bottom: parent.bottom
        }
    }
}
