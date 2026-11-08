import QtQuick

Item {
    id: root

    property string text: ""
    property string icon: ""
    property int iconSize: 15
    property int iconWeight: 500
    property int spacing: 5
    property bool focusable: false

    signal clicked

    focus: true

    implicitWidth: parent.width - 4 * spacing
    implicitHeight: content.implicitHeight
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: background

        anchors.fill: parent
        anchors.margins: -root.spacing

        color: hover.hovered || root.activeFocus ? "lightgrey" : "white"
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
            weight: root.iconWeight
            font.pointSize: root.iconSize
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            text: root.text
            font.pointSize: 13
        }
    }

    TapHandler {
        onTapped: root.clicked()
    }

    HoverHandler {
        id: hover
        margin: root.spacing

        onHoveredChanged: {
            if (root.focusable && hovered)
                root.forceActiveFocus();
        }
    }
}
