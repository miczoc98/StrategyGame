extends PlayerGUI


func _ready():
	yield(get_tree().get_nodes_in_group("player_controller")[0], "ready")
	
	for icon in $Panel/HBoxContainer.get_children():
		icon.connect("building_selected", self, "on_building_selected")
		
func on_building_selected(building: Building) -> void:
	mediator.action("building_selected", [building])
