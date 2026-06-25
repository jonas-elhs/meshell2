import QtQuick
import Quickshell
import Quickshell.Wayland
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
    }

    SystemClock {
        id: time
        precision: SystemClock.Minutes
    }
}
