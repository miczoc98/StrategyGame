extends PlayerController

var building_under_cursor: Building 

func init():
	GlobalMediator.subscribe("building_selected", funcref(self, "_on_building_selected"))


func _on_building_selected(building):
	if building is Castle:
		mediator.action("castle_selected", [building])
