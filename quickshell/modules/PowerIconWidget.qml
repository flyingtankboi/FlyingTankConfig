import QtQuick
import Quickshell
import qs
import qs.components as Components
import qs.bar as Bar
import QtQuick.Layouts

Item {
	id : widget

	required property string icon
	required property int fontSize

	property string fontFamily : "JetBrainsMono Nerd Font"

	Components.IconButton{
		id : button
		onTapped:{powerHud.open = !powerHud.open}
		anchors.fill : parent

		icon : widget.icon
		fontSize : widget.fontSize
	}

	Components.HUDPanel{
		id : powerHud
		anchor.item : widget
		open : false
		title : "Power"
		anchor.edges: Edges.Bottom | Edges.Right
		anchor.gravity: Edges.Bottom | Edges.Left
		anchor.margins.bottom : -8
		anchor.margins.right : -1
		//anchor.rect.y : widget.y + widget.height + 3

		RowLayout {
			spacing : 5
			width : 100
			height : 15

			Components.IconButton{
				id : button1
				onTapped:{Quickshell.execDetached(["systemctl", "suspend"])}

				Layout.fillWidth : true
				Layout.fillHeight : true

				icon : "\u{f0904}"
				fontSize : widget.fontSize
			}

			Components.IconButton{
				id : button2
				onTapped:{Quickshell.execDetached(["systemctl", "reboot"])}

				Layout.fillWidth : true
				Layout.fillHeight : true

				icon : "\u{f0709}"
				fontSize : widget.fontSize
			}

			Components.IconButton{
				id : button3
				onTapped:{Quickshell.execDetached(["systemctl", "poweroff"])}

				Layout.fillWidth : true
				Layout.fillHeight : true

				icon : "\u{f0901}"
				fontSize : widget.fontSize
			}
		}
	}	
}
