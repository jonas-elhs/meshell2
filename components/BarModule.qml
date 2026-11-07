import QtQuick
import qs.components

Rectangle {
    id: root

    default property alias contentData: content.data
    property int padding: 10
    property bool adjustContentSpacing: true
    property bool styled: true

    signal scrolled(event: WheelEvent)

    color: styled ? "white" : "transparent"
    radius: 10
    border.width: styled ? 2 : 0
    border.color: hover.hovered ? "cyan" : "grey"

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Column {
        id: content

        width: parent.width
        spacing: root.padding + (root.adjustContentSpacing ? root.padding / 2 - 2 : 0) // - 2: 2 = border width, can't use because doesn't work if not styled
        topPadding: root.styled ? root.padding : 0
        bottomPadding: root.styled ? root.padding : 0
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
