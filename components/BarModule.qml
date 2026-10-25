import QtQuick
import qs.components

Rectangle {
    id: root

    default property alias contentData: content.data
    property int padding: 10
    property bool adjustVerticalPadding: true
    property bool styled: true

    signal scrolled(event: WheelEvent)

    readonly property int verticalContentPadding: root.padding - (root.adjustVerticalPadding ? (root.padding / 2 - root.border.width) / 2 : 0)

    color: styled ? "white" : "transparent"
    radius: 10
    border.width: styled ? 2 : 0
    border.color: hover.hovered ? "cyan" : "grey"

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Column {
        id: content

        width: parent.width
        spacing: root.padding
        topPadding: root.styled ? root.verticalContentPadding : 0
        bottomPadding: root.styled ? root.verticalContentPadding : 0
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
