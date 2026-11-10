import QtQuick
import qs.components

FocusScope {
    id: root

    default property alias contentData: content.data
    property int padding: Config.spacing / 2
    property bool adjustContentSpacing: true
    property bool styled: true

    signal scrolled(event: WheelEvent)

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Rectangle {
        id: background

        anchors.fill: parent

        color: root.styled ? Color.transparent(Config.backgroundColor, 0.01) : "transparent"
        radius: Config.borderRadius
        border.width: root.styled ? Config.borderWidth : 0
        border.color: hover.hovered || root.activeFocus ? Config.accentColor : Config.inactiveColor

        Behavior on border.color {
            CustomColorAnimation {}
        }
    }

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
}
