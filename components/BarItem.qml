import QtQuick

Column {
    id: root

    required property string icon
    required property string text

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
