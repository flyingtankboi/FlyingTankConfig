import QtQuick
import Quickshell.Hyprland
import qs
import qs.components as Components
import Quickshell.Services.UPower

// Battery bar with very close code to the workspaces bar
Item {
    id: widget

    // ── Geometry ──────────────────────────────────────────────
    property int count: 10
    property real angle: -25
    property real barHeight: 22
    property real gap: 10               // px between two occupied neighbours

    // Width difference from an occupied bar, as a fraction of `gap`
    //property real activeDelta: 0.2     // +50 % of gap: wider
    property real emptyDelta: -0.3     // −100 % of gap: narrower

    property real normalHeight: Math.round(barHeight * 0.8)
    property real emptyHeight: Math.round(barHeight * 0.5)
    property real emptyOffset: 1       // optical centering for the small bars

    // ── Colors ────────────────────────────────────────────────
    property color lowColor: Theme.colors.urgent
    property color chargedColor: Theme.colors.fg
    property color unchargedColor: Theme.colors.surface

    // ── Charging wave (ms) ────────────────────────────────────
    property int waveStep: 100         // delay between two neighbouring cells
    property int waveUp: 300           // rise duration
    property int waveDown: 300         // fall duration
    property int wavePause: 2000       // rest between two waves
    readonly property int wavePeriod: waveUp + waveDown + wavePause

    // One shared clock for every cell (0 → 1, looping)
    property real wavePhase: 0
    NumberAnimation on wavePhase {
        running: widget.isCharging
        from: 0; to: 1
        duration: widget.wavePeriod
        loops: Animation.Infinite
    }

    // ── Size ──────────────────────────────────────────────────
    // Room at both ends: the tallest bar's slant, plus any part of the
    // active bar that is wider than its slot. Neither depends on the
    // widget's width, so there's no binding loop.
    readonly property real edgePadding:
        Math.abs(Math.tan(angle * Math.PI / 180) * barHeight) / 2
        - (gap / 2)

    // Slot width (= distance between centers), from the width we're given
    readonly property real pitch: (width - 2 * edgePadding) / count

    // Bar widths per state
    readonly property real chargedWidth: pitch - gap
    readonly property real unchargedWidth: Math.max(1, chargedWidth + emptyDelta * gap)

    // Default size if no width is set from outside
    implicitWidth: count * 16 + 2 * edgePadding
    height: barHeight

    // For testing 
    //readonly property int batteryPower : 66
    //readonly property bool isPlugged : true
    
    // Battery stats
    readonly property var battery: UPower.displayDevice
    readonly property int batteryPower: battery ? Math.round(battery.percentage * 100) : 0
    readonly property bool isPlugged: !UPower.onBattery
    readonly property bool isCharging: battery !== null && battery.state === UPowerDeviceState.Charging

    Repeater {
        model: widget.count

        delegate: Components.Parallelogram {
            id : segment
            readonly property int fIndex : (widget.count - 1) - index

            readonly property bool isOn: {
                return (widget.batteryPower / widget.count) > fIndex
            }
            readonly property int remainder: {
              
                if (widget.count === 0) return 10; 
                
                if (Math.floor(widget.batteryPower / widget.count) === fIndex) {
                    console.log(index, widget.batteryPower % widget.count)
                    return widget.batteryPower % widget.count;
                }
                return 10;
            }
            readonly property bool isRed : index == widget.count-1

            // Charging wave: this cell's time in the cycle, offset by its index
            readonly property real waveTime:
                ((widget.wavePhase * widget.wavePeriod - index * widget.waveStep)
                 % widget.wavePeriod + widget.wavePeriod) % widget.wavePeriod

            // 0 → 1 → 0 (InQuad up, OutQuad down), 0 during the pause or not charging
            readonly property real bump:
                !widget.isCharging ? 0
                : waveTime < widget.waveUp ? Math.pow(waveTime / widget.waveUp, 2)
                : waveTime < widget.waveUp + widget.waveDown
                    ? Math.pow(1 - (waveTime - widget.waveUp) / widget.waveDown, 2)
                : 0

            // Peak size, same as before: full bar height when on, x1.4 when empty
            readonly property real peakScale: isOn ? widget.barHeight / widget.normalHeight : 1.4


            x: widget.edgePadding + index * widget.pitch + (widget.pitch - width) / 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: (isOn) ? 0 : widget.emptyOffset

            angle: widget.angle

            function log10(value){
                if (value <= 0) return NaN;
                return Math.log(value)/Math.LN10
            }

            width: isOn ? widget.chargedWidth * (6*log10(remainder)+4)/10
                 : widget.unchargedWidth
                  
            height: (isOn ? widget.normalHeight : widget.emptyHeight)
                    * (1 + bump * (peakScale - 1))

            color: isRed ? widget.lowColor
                 : isOn ? widget.chargedColor
                 : widget.unchargedColor
        }
    }
    Components.ChevronReadout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: -17
        
        height : 22
        fontPixelSize : 11

        value: widget.batteryPower
        color: widget.isPlugged ? Theme.colors.fg : Theme.colors.peach
    }
}
