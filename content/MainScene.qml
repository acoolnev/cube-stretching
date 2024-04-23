import QtQuick 6.6
import QtQuick.Controls 6.6
import QtQuick3D 6.6
import QtQuick3D.Effects 6.6
import CubeStretching

Rectangle {
    // Make the rectangle to expand to the application window i.e. parent.
    // If parent is null then the component is running in Qt Design Studio puppet window.
    width: parent ? parent.width : Constants.width
    height: parent ? parent.height : Constants.height

    View3D {
        id: view3D
        anchors.fill: parent

        environment: sceneEnvironment

        SceneEnvironment {
            id: sceneEnvironment

            clearColor: Constants.backgroundColor
            backgroundMode: SceneEnvironment.Color

            antialiasingMode: SceneEnvironment.MSAA
            antialiasingQuality: SceneEnvironment.High
        }

        Node {
            id: scene

            DirectionalLight {
                id: directionalLight
                eulerRotation.x: -10
                z: 600
                brightness: 1
            }

            PerspectiveCamera {
                id: sceneCamera
                y: 250
                z: 500
                eulerRotation.x: -30
            }

            Node {
                Repeater3D {
                    id: xRepeater
                    model: Constants.cubeCount

                    Repeater3D {
                        id: yRepeater
                        readonly property int xIndex: index
                        model: Constants.cubeCount

                        Repeater3D {
                            id: zRepeater
                            readonly property int yIndex: index
                            model: Constants.cubeCount

                            Cube {
                                id: cube

                                // The fist cube (index 0) offset relative to the origin e.g. if cube
                                // count is 5 then offset is 2 so that the middle cube (index 3) is
                                // placed to the origin.
                                readonly property int offset: Constants.cubeCount / 2

                                readonly property int xIndex: parent.parent.xIndex - offset
                                readonly property int yIndex: parent.yIndex - offset
                                readonly property int zIndex: index - offset

                                x: xIndex * Constants.cubeSize
                                y: yIndex * Constants.cubeSize
                                z: zIndex * Constants.cubeSize

                                ParallelAnimation {
                                    id: animation;
                                    running: true

                                    function getAnimationStartPoint(index)
                                    {
                                        return index * Constants.cubeSize;
                                    }

                                    function getAnimationEndPoint(index)
                                    {
                                        return index * Constants.cubeSize * Constants.stretchScale;
                                    }

                                    SequentialAnimation {
                                        loops: Animation.Infinite
                                        NumberAnimation { target: cube; property: "x";
                                                          duration: Constants.stretchDuration;
                                                          from: animation.getAnimationStartPoint(xIndex);
                                                          to:   animation.getAnimationEndPoint(xIndex);
                                        }
                                        NumberAnimation { target: cube; property: "x";
                                                          duration: Constants.stretchDuration;
                                                          from: animation.getAnimationEndPoint(xIndex);
                                                          to:   animation.getAnimationStartPoint(xIndex);
                                        }
                                    }

                                    SequentialAnimation {
                                        loops: Animation.Infinite
                                        NumberAnimation { target: cube; property: "y";
                                                          duration: Constants.stretchDuration;
                                                          from: animation.getAnimationStartPoint(yIndex);
                                                          to:   animation.getAnimationEndPoint(yIndex);
                                        }
                                        NumberAnimation { target: cube; property: "y";
                                                          duration: Constants.stretchDuration;
                                                          from: animation.getAnimationEndPoint(yIndex);
                                                          to:   animation.getAnimationStartPoint(yIndex);
                                        }
                                    }

                                    SequentialAnimation {
                                        loops: Animation.Infinite
                                        NumberAnimation { target: cube; property: "z";
                                                          duration: Constants.stretchDuration;
                                                          from: animation.getAnimationStartPoint(zIndex);
                                                          to:   animation.getAnimationEndPoint(zIndex);
                                        }
                                        NumberAnimation { target: cube; property: "z";
                                                          duration: Constants.stretchDuration;
                                                          from: animation.getAnimationEndPoint(zIndex);
                                                          to:   animation.getAnimationStartPoint(zIndex);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

            }
        }
    }

    Item {
        id: __materialLibrary__
    }
}
