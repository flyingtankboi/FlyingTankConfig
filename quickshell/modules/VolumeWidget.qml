import QtQuick
import qs
import qs.components as Components
import Quickshell.Services.Pipewire

Item {
    id: widget

    property int count: 10
    property real angle: 25
    property real barHeight: 10
    property real gap: 2

    property int fontSize: 12
    property string fontFamily: Theme.fonts.family

    property string offIcon  : "\uf026"
    property string lowIcon  : "\uf027"
    property string midIcon  : "\uefcf"
    property string highIcon : "\uf028"

    property color whiteColor: Theme.colors.fill
    property color redColor: Theme.colors.signal
    property color darkColor: Theme.colors.surface

    property real emptyDelta: -0.3

    property real normalHeight: Math.round(barHeight * 0.8)
    property real emptyHeight: Math.round(barHeight * 0.5)

    //property int volume: 65

    readonly property real edgePadding: Math.abs(Math.tan(angle * Math.PI / 180) * barHeight) / 2
    readonly property real pitch: (column.height - 2 * edgePadding) / count
    readonly property real onWidth: pitch - gap
    readonly property real offWidth: Math.max(1, onWidth + emptyDelta * gap)

    implicitWidth: Math.max(barHeight, volumeIcon.implicitWidth)
    implicitHeight: count * 16


    property real volume: Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio 
                                 ? Math.round(Pipewire.defaultAudioSink.audio.volume * 100)
                                 : 0.0

    function setVolumeFromY(y) {
        const usable = column.height
        const fraction = 1 - y / usable
        Pipewire.defaultAudioSink.audio.volume = Math.max(0, Math.min(1, fraction))
        console.log(y)
    }

    PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
    }

    Item {
        id: column
        anchors.top: parent.top
        anchors.bottom: volumeIcon.top
        anchors.left: parent.left
        anchors.right: parent.right



        MouseArea{
            anchors.fill : parent
            


            onPressed : (mouse) => widget.setVolumeFromY(mouse.y)
            onPositionChanged: (mouse) => { if (pressed) widget.setVolumeFromY(mouse.y) }
        }

        Repeater {
            model: widget.count

            delegate: Components.Parallelogram {
                id: bar
                required property int index

                readonly property int slot: widget.count - 1 - index
                readonly property real centerY: widget.edgePadding + slot * widget.pitch + widget.pitch / 2

                readonly property bool isOn: (widget.volume / widget.count) > index
                readonly property int remainder: {
                    if (widget.count === 0) return 10
                    if (Math.floor(widget.volume / widget.count) === index)
                        return widget.volume % widget.count
                    return 10
                }
                readonly property bool isRed: index === 0

                function log10(value) {
                    if (value <= 0) return 0
                    return Math.log(value) / Math.LN10
                }

                rotation: 90
                angle: widget.angle

                width: isOn ? widget.onWidth * (6 * log10(remainder) + 4) / 10
                            : widget.offWidth
                height: isOn ? widget.normalHeight : widget.emptyHeight

                x: column.width / 2 - width / 2
                y: centerY - height / 2

                color: isRed && isOn ? widget.redColor
                     : isOn ? widget.whiteColor
                     : widget.darkColor
            }
        }
    }

    Text {
        id: volumeIcon
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        text: 0 == widget.volume ? widget.offIcon :
        widget.volume < 33 ? widget.lowIcon :
        widget.volume < 66 ? widget.midIcon :
        widget.highIcon



        font.family: widget.fontFamily
        font.pixelSize: widget.fontSize
        color: Theme.colors.fg
    }
}