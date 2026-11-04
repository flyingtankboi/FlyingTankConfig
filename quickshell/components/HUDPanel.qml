import QtQuick
import QtQuick.Shapes
import Quickshell
import qs

// Beveled HUD popup with a window-style title bar.
// Use `open` (not `visible`) so opening and closing animate.
PopupWindow {
    id: root

    property bool open: false
    property string title: ""
    default property alias content: body.data
    property bool fromRight: true                                      // true: grows right → left

    // Shape
    readonly property real cut: 12                                     // bevel width
    readonly property real cutH: cut / Math.tan(25 * Math.PI / 180)    // bevel height (parallel to the bars)
    readonly property real gap: 4                                      // space between the two lines
    readonly property real pad: 12                                     // inner padding
    readonly property real barH: 22                                    // title bar height (keep below cutH)

    // Smallest frame while growing (wide enough for the top bevel + some bar)
    readonly property real minW: gap * 2
    readonly property real minH: gap * 2 + barH

    // Inner bevel offsets, so the inner line stays parallel to the outer one
    readonly property real len: Math.sqrt(cut * cut + cutH * cutH)
    readonly property real offA: gap * (len - cut) / cutH
    readonly property real offB: gap * (len - cutH) / cut

    // x where the inner bevel line crosses the bar's bottom edge
    readonly property real barCutX: {
        var x1 = frame.width - cut - offA, y1 = gap
        var x2 = frame.width - gap,        y2 = cutH + offB
        var t = (gap + barH - y1) / (y2 - y1)
        return x1 + t * (x2 - x1)
    }

    // Reveal progress: 0 = hidden, 1 = shown
    property real revealX: 0
    property real revealY: 0

    color: "transparent"
    visible: open || revealX > 0

    // Full size, from the content
    implicitWidth: Math.max(body.childrenRect.width, titleText.implicitWidth + 40) + 2 * (pad + gap)
    implicitHeight: gap + barH + pad + body.childrenRect.height + pad + gap

    onOpenChanged: {
        if (open) { closeAnim.stop(); openAnim.restart() }
        else      { openAnim.stop(); closeAnim.restart() }
    }

    // Open: the bar extends, then the panel drops down
    SequentialAnimation {
        id: openAnim
        NumberAnimation { target: root; property: "revealX"; to: 1; duration: Theme.anim.fast; easing.type: Easing.OutCubic }
        NumberAnimation { target: root; property: "revealY"; to: 1; duration: Theme.anim.normal; easing.type: Easing.OutCubic }
    }

    // Close: the same in reverse
    SequentialAnimation {
        id: closeAnim
        NumberAnimation { target: root; property: "revealY"; to: 0; duration: Theme.anim.fast; easing.type: Easing.InCubic }
        NumberAnimation { target: root; property: "revealX"; to: 0; duration: Theme.anim.fast; easing.type: Easing.InCubic }
    }

    // Catch clicks and scrolls on the panel itself, so nothing behind it gets them
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons
        hoverEnabled: true
        onWheel: (wheel) => wheel.accepted = true
    }

    // The frame itself grows (horizontally, then down)
    Item {
        id: frame
        anchors.top: parent.top
        x: root.fromRight ? root.width - width : 0
        width: root.minW + (root.width - root.minW) * root.revealX
        height: root.minH + (root.height - root.minH) * root.revealY
        opacity: Math.min(1, root.revealX * 4)   // quick fade at the very start / end

        Shape {
            anchors.fill: parent
            preferredRendererType: Shape.CurveRenderer

            // Outer line + background
            // (the bottom-left bevel grows with the drop-down, square while only the bar shows)
            ShapePath {
                strokeColor: Theme.colors.peach
                strokeWidth: 1
                fillColor: Theme.alpha(Theme.colors.base, 0.9)

                startX: 0; startY: 0
                PathLine { x: frame.width - root.cut; y: 0 }
                PathLine { x: frame.width; y: root.cutH }
                PathLine { x: frame.width; y: frame.height }
                PathLine { x: root.cut * root.revealY; y: frame.height }
                PathLine { x: 0; y: frame.height - root.cutH * root.revealY }
                PathLine { x: 0; y: 0 }
            }

            // Title bar (cream, cut by the bevel)
            ShapePath {
                strokeColor: "transparent"
                strokeWidth: 0
                fillColor: Theme.colors.text

                startX: root.gap; startY: root.gap
                PathLine { x: frame.width - root.cut - root.offA; y: root.gap }
                PathLine { x: root.barCutX; y: root.gap + root.barH }
                PathLine { x: root.gap; y: root.gap + root.barH }
                PathLine { x: root.gap; y: root.gap }
            }

            // Inner line, inset by `gap` (drawn last, so it frames the bar)
            ShapePath {
                strokeColor: Theme.colors.peachDk
                strokeWidth: 1
                fillColor: "transparent"

                startX: root.gap; startY: root.gap
                PathLine { x: frame.width - root.cut - root.offA; y: root.gap }
                PathLine { x: frame.width - root.gap; y: root.cutH + root.offB }
                PathLine { x: frame.width - root.gap; y: frame.height - root.gap }
                PathLine { x: Math.max(root.gap, (root.cut + root.offA) * root.revealY); y: frame.height - root.gap }
                PathLine { x: root.gap; y: frame.height - Math.max(root.gap, (root.cutH + root.offB) * root.revealY) }
                PathLine { x: root.gap; y: root.gap }
            }
        }

        // Title (appears once the bar is fully extended)
        Text {
            id: titleText
            x: root.gap + 8
            y: root.gap + (root.barH - height) / 2
            text: "//" + root.title
            color: Theme.colors.base
            font.family: Theme.fonts.family
            font.pixelSize: Theme.fonts.sm
            font.bold: true
            font.capitalization: Font.AllUppercase

            opacity: root.revealX >= 1 ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: Theme.anim.fast } }
        }

        // Close button (red square, left of the bevel)
        Rectangle {
            width: 8
            height: 8
            x: frame.width - root.cut - root.offA - width - 8
            y: root.gap + (root.barH - height) / 2
            color: Theme.colors.urgent

            opacity: root.revealX >= 1 ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: Theme.anim.fast } }

            MouseArea {
                anchors.fill: parent
                anchors.margins: -4              // bigger click area than the square
                cursorShape: Qt.PointingHandCursor
                onClicked: root.open = false
            }
        }

        // Content area under the bar (clipped while the panel drops down)
        Item {
            x: root.gap
            y: root.gap + root.barH
            width: frame.width - 2 * root.gap
            height: Math.max(0, frame.height - root.barH - 2 * root.gap)
            clip: true
            opacity: root.revealY

            // Your content goes here
            Item {
                id: body
                x: root.pad
                y: root.pad
            }
        }
    }
}