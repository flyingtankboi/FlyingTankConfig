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
                bottom: true 
            }

            // On Off switch
            visible : ShellState.sideBarOpen || container.x > -container.width
            implicitWidth : 25
            
            // The window is invisible; the bar and the tab draw themselves
            color: "transparent"

            Item {
                id : container
                width : parent.width
                height : parent.height
                // Move away
                x : ShellState.sideBarOpen ? 0 : -barInstance.implicitWidth
                Behavior on x {
                    NumberAnimation {
                        duration : Theme.anim.fast
                        easing.type: ShellState.sideBarOpen ? Easing.OutCubic : Easing.InCubic
                    }
                }

                // Bar border
                Rectangle {
                    id: border
                    width: 1
                    height : parent.height
                    x: parent.width - 1
                    color: Theme.colors.peach
                }
                
                // 1. The bar itself
                Rectangle {
                    id: barBackground
                    anchors.left : parent.left
                    anchors.bottom:parent.bottom
                    height: parent.height-1
                    width: parent.width-1

                    color: Theme.alpha(Theme.colors.base, 0.5)

                    
                }
            }
        }
    }
}
