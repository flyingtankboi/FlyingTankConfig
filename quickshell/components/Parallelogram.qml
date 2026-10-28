import QtQuick
import QtQuick.Shapes
import qs

// A slanted bar. width × height = its footprint at mid-height;
// the slant sticks out beyond that box by `overhang` on each side.
Item {
    id: root

    property real angle: 25                    // degrees; positive = top leans right
    property color color: Theme.colors.fill
    property color strokeColor: "transparent"  // outline, e.g. for locked battery cells
    property real strokeWidth: 0

    // How far the top edge is shifted relative to the bottom edge (signed)
    readonly property real indent: Math.tan(angle * Math.PI / 180) * height
    // How far the slant sticks out of the footprint on each side
    readonly property real overhang: Math.abs(indent) / 2
    // Where the bottom and top edges start inside the drawing
    readonly property real bottomStart: Math.max(0, -indent)
    readonly property real topStart: Math.max(0, indent)

    Shape {
        x: -root.overhang
        width: root.width + Math.abs(root.indent)
        height: root.height
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: root.color
            strokeColor: root.strokeColor
            strokeWidth: root.strokeWidth

            startX: root.bottomStart
            startY: root.height                                            // bottom-left
            PathLine { x: root.bottomStart + root.width; y: root.height }  // bottom-right
            PathLine { x: root.topStart + root.width; y: 0 }               // top-right
            PathLine { x: root.topStart; y: 0 }                            // top-left
            PathLine { x: root.bottomStart; y: root.height }               // back to start
        }
    }
}
