import QtQuick
import qs
import qs.components as Components
import qs.bar as Bar

Item {
	id : widget

	required property string icon
	required property int fontSize

	property string fontFamily : "JetBrainsMono Nerd Font"

	Components.IconButton{
		onTapped:{ShellState.sideBarOpen = !ShellState.sideBarOpen}
		anchors.centerIn : parent
		anchors.fill : parent

		icon : widget.icon
		fontSize : widget.fontSize
	}	
}
