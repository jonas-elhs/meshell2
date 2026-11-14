import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.io
import qs.components

PanelWindow {
    id: root

    required property bool showPowerMenu
    readonly property int barWidth: 40
    signal powerMenuToggleRequested

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

    margins.top: Config.spacing
    margins.left: Config.spacing
    margins.bottom: Config.spacing

    color: "transparent"

    HyprlandFocusGrab {
        active: root.showPowerMenu
        windows: [root]

        onCleared: root.powerMenuToggleRequested()
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

        BarMultiModule {
            anchors.verticalCenter: parent.verticalCenter

            MultiModuleComponent {
                Workspaces {
                    width: content.width
                    styled: false
                }
            }

            MultiModuleComponent {
                condition: root.showPowerMenu

                PowerMenu {
                    styled: false
                    onCloseRequested: root.powerMenuToggleRequested()
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

            onPowerMenuToggleRequested: root.powerMenuToggleRequested()
        }
    }
}
