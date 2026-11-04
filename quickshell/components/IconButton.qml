import QtQuick
import qs
import qs.components as Components
import qs.bar as Bar

Item {
	id : widget

	required property string icon
	required property int fontSize
    signal tapped()
    
	property string fontFamily : "JetBrainsMono Nerd Font"


	Text {
		id: archIcon
		anchors.centerIn : parent

		text: widget.icon

		font.family: widget.fontFamily 

		font.pixelSize: widget.fontSize
		scale : hoverHandler.hovered ? 1.15 : 1.0

		Behavior on font.pixelSize {
			NumberAnimation{
				duration : Theme.anim.fast
				easing.type: Easing.OutCubic
			}
		}

		color: Theme.colors.fg

		//renderType: Text.NativeRendering
	}

	TapHandler{
		id : tapHandler
        onTapped: widget.tapped()
	}

    HoverHandler {
        id: hoverHandler
    }
}