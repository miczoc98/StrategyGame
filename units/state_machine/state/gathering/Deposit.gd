extends State

var deposit_location: Vector2

var _deposit_range = 200


func process(_delta: float):
	if _is_base_in_range():
		for resource in _parent._gathered_resources.keys():
			if (_parent._gathered_resources[resource] > 0):
				GlobalMediator.action("resource_deposited", [resource, _parent._gathered_resources[resource]])
				_parent._gathered_resources[resource] = 0
				_state_machine.change_to("Gathering/Gather")
	else:
		var target = deposit_location
		_state_machine.change_to("Navigating", {"target": target})

func _is_base_in_range():
	return deposit_location.distance_to(global_position) < _deposit_range
	
	
func _get_building_map() -> BuildingGrid:
	return _parent._navigation.get_node("Buildings") as BuildingGrid
