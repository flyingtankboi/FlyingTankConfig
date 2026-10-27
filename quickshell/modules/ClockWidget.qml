import QtQuick
import qs.services as Services
import qs.components as Components

Item {
    id: widgetContainer
    
    // Exposed Configuration Properties
    property color borderColor: "orange"
    property int borderWidth: 2
    property int borderGap: 4         // Horizontal padding gap on the sides
    property int verticalGap: 4       // Vertical padding gap at the bottom
    property int baseIndent: 20       // Outer slope indent
    property int innerIndent: 16      // Adjusted inner slope indent to keep lines parallel
		property string textFont
		property color textColor
		property int textSize
		property color bgColor


    // Default container size
    width: 200
    height: 50

    // Outer Trapeze
    Components.Trapeze {
        anchors.fill: parent

        indent: widgetContainer.baseIndent
        borderWidth: widgetContainer.borderWidth
				borderColor: widgetContainer.borderColor

				bgColor: widgetContainer.bgColor
    }
  
    // Inner Trapeze (Using fixed math variables)
    Components.Trapeze {
        width: parent.width - (widgetContainer.borderGap * 2)
        height: parent.height - widgetContainer.verticalGap
        
        // Centered horizontally, pushed to top edge
        x: (parent.width / 2) - (width / 2)
        y: 0 

        indent: widgetContainer.innerIndent
        borderWidth: widgetContainer.borderWidth
        borderColor: widgetContainer.borderColor
    }

    // Foreground Clock Text
    Text {
				//anchors.centerIn: parent
				x: (parent.width/2) -(width/2)
				y: (parent.height/2) - (height/2)-3

        text: Services.Time.time
				color: widgetContainer.textColor

				font.pixelSize: widgetContainer.textSize
        font.family: widgetContainer.textFont
        font.bold: true
    }
}
