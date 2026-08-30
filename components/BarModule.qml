import QtQuick
import qs.components

Rectangle {
    id: root

    default property alias contentData: content.data
    property int padding: 10

    signal scrolled(event: WheelEvent)

    color: "white"
    radius: 10
    border.width: 2
    border.color: hover.hovered ? "cyan" : "grey"

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Column {
        id: content

        width: parent.width
        spacing: root.padding
        topPadding: root.padding - (root.padding / 2 - 2) / 2 // - 2 = border.width
        bottomPadding: root.padding - (root.padding / 2 - 2) / 2 // - 2 = border.width
    }

    HoverHandler {
        id: hover
    }

    WheelHandler {
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: event => root.scrolled(event)
    }

    Behavior on border.color {
        CustomColorAnimation {}
    }
}
