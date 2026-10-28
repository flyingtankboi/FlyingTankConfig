import QtQuick
import Quickshell.Hyprland
import qs
import qs.components as Components

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
    property color lowColor: Theme.colors.signal
    property color chargedColor: Theme.colors.fill
    property color unchargedColor: Theme.colors.overlay

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

    Repeater {
        model: widget.count

        delegate: Components.Parallelogram {
            required property int index

            // TODO REPLACE WITH BATTERY LOGIC + HOW TO ANIMATE !
            readonly property int wsId: index + 1

            readonly property var ws: {
                var _trigger1 = Hyprland.focusedWorkspace
                var _trigger2 = Hyprland.workspaces.count
                return Hyprland.workspaces.values.find(w => w.id === wsId)
            }
            readonly property bool isOccupied: ws !== undefined && ws.toplevels.values.length > 0
            readonly property bool isActive: ws !== undefined && ws.active

            // Centered in its slot
            x: widget.edgePadding + index * widget.pitch + (widget.pitch - width) / 2
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: (isActive || isOccupied) ? 0 : widget.emptyOffset

            angle: widget.angle
            width: isActive ? widget.activeWidth
                 : isOccupied ? widget.occupiedWidth
                 : widget.emptyWidth
            height: isActive ? widget.barHeight
                  : isOccupied ? widget.occupiedHeight
                  : widget.emptyHeight
            color: isActive ? widget.activeColor
                 : isOccupied ? widget.occupiedColor
                 : widget.sleepColor

            Behavior on width  { NumberAnimation { duration: Theme.anim.fast; easing.type: Easing.OutBack } }
            Behavior on height { NumberAnimation { duration: Theme.anim.fast; easing.type: Easing.InOutQuad } }
            Behavior on color  { ColorAnimation  { duration: Theme.anim.fast / 2 } }
            Behavior on anchors.verticalCenterOffset { NumberAnimation { duration: Theme.anim.fast } }
        }
    }
}
