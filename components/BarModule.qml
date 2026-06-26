import QtQuick

Rectangle {
    id: root

    default property alias contentData: content.data
    property int padding: 10

    signal scrolled(event: WheelEvent)

    color: "white"
    radius: 10
    border.width: 2
    border.color: hover.hovered ? "cyan" : "grey"

    implicitWidth: content.implicitWidth + 2 * padding
    implicitHeight: content.implicitHeight + 2 * padding

    Column {
        id: content

        spacing: root.padding
        anchors.centerIn: parent
    }

    HoverHandler {
        id: hover
    }

    WheelHandler {
        acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad
        onWheel: event => root.scrolled(event)
    }
}
