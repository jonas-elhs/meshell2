import QtQuick

Item {
    id: root

    required property string icon
    required property string text
    property int spacing: 10

    implicitWidth: parent.width
    implicitHeight: content.implicitHeight

    Rectangle {
        id: background

        y: -(root.spacing / 2)
        x: root.spacing / 2
        radius: root.spacing - (root.spacing / 2)
        implicitWidth: parent.width - root.spacing
        implicitHeight: parent.height + root.spacing

        color: hover.hovered ? "lightgrey" : "transparent"

        Behavior on color {
            CustomColorAnimation {}
        }
    }

    Column {
        id: content

        anchors.horizontalCenter: parent.horizontalCenter

        MaterialIcon {
            icon: root.icon
            color: "cyan"
            weight: 500
            font.pointSize: 15

            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: root.text
            font.pointSize: 13

            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    HoverHandler {
        id: hover
    }
}
