import QtQuick

Rectangle {
    id: root

    default property alias contentData: content.data
    property int padding: 10
    property bool hovered: mouseArea.containsMouse

    color: "white"
    radius: 10
    border.width: 2
    border.color: hovered ? "cyan" : "grey"

    implicitWidth: content.implicitWidth + 2 * padding
    implicitHeight: content.implicitHeight + 2 * padding

    Column {
        id: content

        x: root.padding
        y: root.padding

        spacing: root.padding
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}
