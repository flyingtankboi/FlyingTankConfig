import Quickshell
import QtQuick
import QtQuick.Shapes

Shape {
  id: root

  required property int indent;
  required property int borderWidth;
  required property color borderColor;
  
  property color bgColor : "transparent"

  width : Shape.width
  height : Shape.height

  layer.smooth : true
  layer.enabled : true
  //layer.samples : 6
  preferredRendererType: Shape.CurveRenderer

  ShapePath {
    strokeWidth : root.borderWidth
    strokeColor : root.borderColor
    strokeStyle : ShapePath.SolidLine
    capStyle : ShapePath.SquareCap
    joinStyle : ShapePath.MiterJoin

    fillColor : root.bgColor

    startX : strokeWidth 
    startY: 0
    PathLine { x: root.indent + root.borderWidth; y: root.height - root.borderWidth }
    PathLine { x: root.width - (root.indent + root.borderWidth); y: root.height - root.borderWidth }
    PathLine { x: root.width - root.borderWidth; y: 0 }
  }
}
