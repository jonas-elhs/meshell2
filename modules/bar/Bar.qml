import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import qs.components

PanelWindow {
    id: root

    required property bool showPowerMenu
    readonly property int barWidth: 40
    signal powerMenuRequested

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

    HyprlandFocusGrab {
        active: root.showPowerMenu
        windows: [root]

        onCleared: root.powerMenuRequested()
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
                    onCloseRequested: root.powerMenuRequested()
                }
            }
        }

        SystemStats {
            id: system

            width: content.width
            anchors.bottom: power.top
            anchors.bottomMargin: 20
        }
        PowerButton {
            id: power

            width: content.width
            anchors.bottom: parent.bottom

            onPowerMenuRequested: root.powerMenuRequested()
        }
    }
}
