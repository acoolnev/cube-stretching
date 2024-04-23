pragma Singleton
import QtQuick 6.6

QtObject {
    readonly property int width: 1024
    readonly property int height: 768

    readonly property color backgroundColor: "black"

    readonly property real cubeCount: 5
    readonly property real cubeScale: 0.5
    readonly property int cubeSize: 100 * cubeScale

    readonly property real stretchScale: 2

    readonly property int stretchDuration: 2000 // milliseconds
}
