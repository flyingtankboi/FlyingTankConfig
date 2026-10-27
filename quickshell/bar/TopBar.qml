import QtQuick
import Quickshell
import QtQuick.Layouts
import qs
import qs.modules as Modules

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barInstance

            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            // Tall enough for the bar AND the hanging clock tab…
            readonly property int barHeight: 35
            readonly property int tabHeight: 42
            implicitHeight: Math.max(barHeight, tabHeight)

            // …but windows only make room for the bar itself
            exclusiveZone: barHeight

            // The window is invisible; the bar and the tab draw themselves
            color: "transparent"

            // Clicks only land on the bar and the tab; elsewhere they pass through
            mask: Region {
                item: barBackground
                Region { item: clock; intersection: Intersection.Combine }
            }

            // Bar border left
            Rectangle {
              id: border1
              width: parent.width/2-46
              height: 1
              y:barInstance.barHeight
              color: Theme.colors.peach
            }
            // Bar border right
            Rectangle {
              id: border2
              width: parent.width/2-46
              height: 1
              x: parent.width/2+46
              y:barInstance.barHeight
              color: Theme.colors.peach
            }

            // 1. The bar itself
            Rectangle {
                id: barBackground
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                } 

                height: barInstance.barHeight
                color: Theme.alpha(Theme.colors.base, 0.5)

                Item {
                    id: barWidgetsContainer
                    anchors.fill: parent

                    Text {
                      id: archIcon
                      anchors.verticalCenter: parent.verticalCenter
                      anchors.left: parent.left
                      anchors.leftMargin: 6
                      
                      text: "\uf303" 
                      
                      font.family: "JetBrainsMono Nerd Font" 
                      
                      font.pixelSize: 23
                      color: Theme.colors.fg
                      
                      renderType: Text.NativeRendering
                   }
                  
                   Modules.WorkspaceWidget{
                       width : 240
                       height : 19
                       distance : -48
                       angle : 25.0

                       anchors.left : archIcon.right
                       anchors.leftMargin : 32
                       anchors.verticalCenter: parent.verticalCenter

                       activeColor : Theme.colors.urgent
                       occupiedColor : Theme.colors.fg
                       sleepColor : Theme.colors.surface
                   }
                }
            }


            // 2. The clock tab, declared after the bar so it's drawn on top
            Modules.ClockWidget {
                id: clock
                width: 130
                height: barInstance.tabHeight
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                borderColor: Theme.colors.peach
                borderWidth: 2
                borderGap: 5
                verticalGap: 4
                baseIndent: 20
                innerIndent: 18
                bgColor: Theme.alpha(Theme.colors.base, 0.5)

                textFont: Theme.fonts.family
                textColor: Theme.colors.fg
                textSize: Theme.fonts.clock
            }
        }
    }
}
