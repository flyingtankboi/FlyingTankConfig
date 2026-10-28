import QtQuick
import QtQuick.Shapes
import qs

// Number with two chevrons pointing at it (top ▼, bottom ▲)
Item {
    id: root

    property var value: 0
    property int digits: 2               // zero-padding: 3 → "03"
    property color color: Theme.colors.fg

    // ── Geometry ──────────────────────────────────────────────
    property real chevronWidth: 6
    property real chevronHeight: 3
    property real chevronStroke: 1
    property real spacing: 2             // between chevrons and number

    // Text
    property string fontFamily: Theme.fonts.family
    property int fontPixelSize: Theme.fonts.sm
    property bool fontBold: true

    implicitWidth: Math.max(label.implicitWidth, chevronWidth)
    implicitHeight: label.implicitHeight + 2 * (chevronHeight + spacing)

    Behavior on color { ColorAnimation { duration: Theme.anim.normal } }

    // Top chevron, pointing down
    Shape {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: root.chevronWidth
        height: root.chevronHeight
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: "transparent"
            strokeColor: root.color
            strokeWidth: root.chevronStroke
            joinStyle: ShapePath.MiterJoin

            startX: 0; startY: 0
            PathLine { x: root.chevronWidth / 2; y: root.chevronHeight }
            PathLine { x: root.chevronWidth; y: 0 }
        }
    }

    Text {
        id: label
        anchors.centerIn: parent
        text: typeof root.value === "number" ? String(root.value).padStart(root.digits, "0")
        : root.value
        color: root.color
        font.family: root.fontFamily
        font.pixelSize: fontPixelSize 
        font.bold: fontBold
    }

    // Bottom chevron, pointing up
    Shape {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin : 2
        width: root.chevronWidth
        height: root.chevronHeight
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: "transparent"
            strokeColor: root.color
            strokeWidth: root.chevronStroke
            joinStyle: ShapePath.MiterJoin

            startX: 0; startY: root.chevronHeight
            PathLine { x: root.chevronWidth / 2; y: 0 }
            PathLine { x: root.chevronWidth; y: root.chevronHeight }
        }
    }
}
