extends PlayerController

var building_under_cursor: Building 

func _ready():
	yield(get_tree().get_nodes_in_group("player_controller")[0], "ready")
	
	mediator.subscribe("building_placed", funcref(self, "_on_building_placed"))
	GlobalMediator.subscribe("building_selected", funcref(self, "_on_building_selected"))


func _on_building_selected(building):
	if building is Castle:
		building.set_resources(player.resources)
		mediator.action("castle_selected", [building])
