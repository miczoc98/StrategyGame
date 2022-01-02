extends PlayerGUI


func init():	
	for icon in $Panel/HBoxContainer.get_children():
		icon.connect("building_selected", self, "on_building_selected")
		

func on_building_selected(building: Building) -> void:
	mediator.action("building_selected", [building])
