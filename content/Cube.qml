import QtQuick 6.6
import QtQuick3D 6.6
import CubeStretching

Model {
    id: cube
    source: "#Cube"
    scale: Qt.vector3d(Constants.cubeScale, Constants.cubeScale, Constants.cubeScale)
    property color cubeColor: "green"
    materials: [
        DefaultMaterial {
            diffuseColor: cube.cubeColor
        }
    ]
}
