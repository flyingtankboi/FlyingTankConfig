import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.components as Components
import qs

RowLayout{
  id : widget

  property real angle : 25.0
  property int distance : -12
  spacing:distance

  property color activeColor:"red"
  property color occupiedColor:"white"
  property color sleepColor:"grey"
  

  Repeater{
    id : repeater
    model: 10
    
    // A item holds the logic and calls parallelogram, fixed width and height for correct tiling 
    delegate:Item{
      id : capsule

      // Hyperlan
      readonly property var ws : { 
        var _trigger1 = Hyprland.focusedWorkspace
        var _trigger2 = Hyprland.workspaces.count

        return Hyprland.workspaces.values.find(w => w.id === wsId)
      }
      readonly property int wsId: index+1
      readonly property bool isOccupied: ws !== undefined && ws.toplevels.values.length >0
      readonly property bool isActive: ws !== undefined && ws.active
     
      Layout.fillHeight : true
      Layout.preferredWidth : widget.width / repeater.model
      clip: false

      Components.Parallelogram{
        id : poly
        anchors.centerIn : parent
        width : parent.width
        angle: widget.angle

        // Animated

        baseWidth: isActive ? width*0.6 : isOccupied ? width*0.5 : width*0.4
        height: isActive ? parent.height : isOccupied ? Math.round(parent.height*0.8) : Math.round(parent.height*0.5)
        color : isActive ? activeColor : isOccupied ? occupiedColor : sleepColor
        anchors.verticalCenterOffset: isActive ? 0 : isOccupied ? 0 : 1 // Human eye biases the smaller parallelograms up

        Behavior on baseWidth { NumberAnimation { duration: Theme.anim.fast; easing.type: Easing.Back } }
        Behavior on height    { NumberAnimation { duration: Theme.anim.fast; easing.type: Easing.InOutQuad } }
        Behavior on color     { ColorAnimation  { duration: Theme.anim.fast/2 } }
        Behavior on anchors.verticalCenterOffset { NumberAnimation { duration: Theme.anim.fast } }
      }
    }
  }
}
