import QtQuick
import qs.io
import qs.components

FocusScope {
    id: root

    default property alias contentData: content.data
    property int padding: Config.spacing / 2
    property bool adjustContentSpacing: true
    property bool styled: true
    property bool alignOnEdge: false

    signal scrolled(event: WheelEvent)

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    x: alignOnEdge ? -Config.spacing : 0

    Squircle {
        id: background

        anchors.fill: parent

        color: root.styled ? Color.transparent(Config.backgroundColor, 0.01) : "transparent"
        radius: Config.borderRadius
        borderWidth: root.styled ? Config.borderWidth : 0
        borderColor: hover.hovered || root.activeFocus ? Config.accentColor : Config.inactiveColor

        Behavior on borderColor {
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
