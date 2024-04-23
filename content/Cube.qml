import QtQuick 6.6
import QtQuick3D 6.6
import CubeStretching

Node {
    Model {
        source: "#Cube"
        scale: Qt.vector3d(Constants.cubeScale, Constants.cubeScale, Constants.cubeScale)
        materials: [
            DefaultMaterial {
                diffuseColor: Qt.rgba(0.3, 0.9, 0.3, 1)
            }
        ]
    }
}
