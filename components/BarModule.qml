import QtQuick
import qs.components

Rectangle {
    id: root

    default property alias contentData: content.data
    property int padding: Config.spacing / 2
    property bool adjustContentSpacing: true
    property bool styled: true

    signal scrolled(event: WheelEvent)

    color: styled ? Color.transparent(Config.backgroundColor, 0.01) : "transparent"
    radius: Config.borderRadius
    border.width: styled ? Config.borderWidth : 0
    border.color: hover.hovered || activeFocus ? Config.accentColor : Config.inactiveColor

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Column {
        id: content

        width: parent.width
        spacing: root.padding + (root.adjustContentSpacing ? root.padding / 2 - Config.borderWidth : 0)
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
