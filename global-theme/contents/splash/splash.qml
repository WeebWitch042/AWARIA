import QtQuick
import QtMultimedia

Rectangle {
    width: 1920
    height: 1080
    color: "#0E1029"

    MediaPlayer {
        id: videoPlayer
        source: "gate.mp4"
        loops: 1
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectFit
    }

    Component.onCompleted: {
        videoPlayer.play()
    }
}