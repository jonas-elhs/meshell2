import QtQuick

Item {
    id: root

    property string icon: ""
    property string text: ""
    property int spacing: 5

    implicitWidth: parent.width - 4 * spacing
    implicitHeight: content.implicitHeight
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: background

        anchors.fill: parent
        anchors.margins: -root.spacing

        color: hover.hovered ? "lightgrey" : "white"
        radius: 10 - root.spacing // 10 = BarModule.padding

        Behavior on color {
            CustomColorAnimation {}
        }
    }

    Column {
        id: content

        anchors.horizontalCenter: parent.horizontalCenter

        MaterialIcon {
            anchors.horizontalCenter: parent.horizontalCenter

            icon: root.icon
            color: "cyan"
            weight: 500
            font.pointSize: 15
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            text: root.text
            font.pointSize: 13
        }
    }

    HoverHandler {
        id: hover
        margin: root.spacing
    }
}
