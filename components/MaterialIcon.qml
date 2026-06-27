import QtQuick

Text {
    property string icon
    property real fill: 0
    property int grade: 0
    property int weight: 10

    text: icon
    font.family: "Material Symbols Rounded"
    font.weight: weight
    font.variableAxes: ({
            FILL: fill.toFixed(1),
            GRAD: grade,
            wght: fontInfo.weight,
            opsz: fontInfo.pixelSize
        })
}
