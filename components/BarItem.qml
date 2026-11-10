import QtQuick

Item {
    id: root

    property string text: ""
    property string icon: ""
    property int iconSize: 15
    property int iconWeight: 500
    property string iconColor: Config.accentColor
    property int spacing: Config.spacing / 4
    property bool focusable: false
    property int acceptedButtons: Qt.LeftButton

    signal clicked(int button)

    focus: true

    implicitWidth: parent.width - 4 * spacing
    implicitHeight: content.implicitHeight
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: background

        anchors.fill: parent
        anchors.margins: -root.spacing

        color: hover.hovered || root.activeFocus ? Color.transparent(Config.foregroundColor, 0.2) : Color.transparent(Config.foregroundColor, 0)
        radius: Config.borderRadius - root.spacing

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
            color: root.iconColor
            weight: root.iconWeight
            font.pointSize: root.iconSize
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            text: root.text
            color: Config.foregroundColor
            font.pointSize: 13
        }
    }

    TapHandler {
        margin: root.spacing
        acceptedButtons: root.acceptedButtons

        onTapped: (_, button) => root.clicked(button)
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
