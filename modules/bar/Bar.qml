import QtQuick
import Quickshell
import Quickshell.Wayland

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
        Rectangle {
            id: clock

            anchors.top: parent.top

            implicitWidth: text.implicitWidth + 10
            implicitHeight: text.implicitHeight + 10

            color: "white"

            Text {
                id: text
                anchors.centerIn: parent
                text: Qt.formatTime(time.date, "hh\nmm")
            }
        }
    }

    SystemClock {
        id: time
        precision: SystemClock.Minutes
    }
}
