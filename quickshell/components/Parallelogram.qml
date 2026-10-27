import Quickshell
import QtQuick
import QtQuick.Shapes

Shape {
  id: root
  
  required property real angle
  required property color color
  property real baseWidth: 12 

  // Use Math.abs to always get a positive indentation size for the geometry calculations
  readonly property int indent : Math.abs(Math.tan(angle * Math.PI / 180) * height)
  
  // Calculate horizontal offset to center the shape within the allocated width
  readonly property real xOffset: (root.width - (baseWidth + indent)) / 2

  // Determine the direction of the lean based on the angle sign
  readonly property bool isNegative: angle < 0

  layer.smooth : true
  layer.enabled : true
  //layer.samples : 6
  preferredRendererType: Shape.CurveRenderer

  ShapePath {
    strokeWidth : 0
    fillColor : root.color

    // Conditional coordinates based on whether the angle is positive or negative
    startX : root.isNegative ? root.xOffset + root.indent : root.xOffset
    startY: root.height
    
    PathLine { 
        x: root.isNegative ? root.xOffset + root.indent + root.baseWidth : root.xOffset + root.baseWidth
        y: root.height 
    }
    PathLine { 
        x: root.isNegative ? root.xOffset + root.baseWidth : root.xOffset + root.baseWidth + root.indent
        y: 0 
    }
    PathLine { 
        x: root.isNegative ? root.xOffset : root.xOffset + root.indent
        y: 0 
    }
  }
}
