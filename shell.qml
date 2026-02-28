import QtQuick
import Quickshell

ShellRoot {
    id: root

    Variants {
        model: Quickshell.screens

        Scope {
            id: scope
            property ShellScreen modelData

            PanelWindow {
                anchors.left: true
                anchors.bottom: true
                anchors.top: true
                anchors.right: true

                screen: scope.modelData
                mask: Region {}
                color: "transparent"

                Rectangle {
                    anchors.centerIn: parent

                    color: "red"
                    width: parent.width / 2
                    height: parent.height / 2
                }
            }
        }
    }
}
