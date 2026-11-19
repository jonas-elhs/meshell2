import QtQuick
import qs.io

ShaderEffect {
    property vector2d size: Qt.vector2d(width, height)

    property real radius: Config.borderRadius
    property real roundingPower: 4
    property real borderWidth: 0

    property color color: "transparent"
    property color borderColor: "transparent"

    fragmentShader: "squircle.frag.qsb"
}
