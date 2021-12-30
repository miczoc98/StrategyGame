extends State

signal resource_deposited()

var _deposit_range = 200

func process(delta: float):
	if _is_base_in_range():
		for resource in _parent._gathered_resources.keys():
			if (_parent._gathered_resources[resource] > 0):
				GlobalMediator.action("resource_deposited", [resource, _parent._gathered_resources[resource]])
				_parent._gathered_resources[resource] = 0
				_state_machine.change_to("Gathering/Gather")
	else:
		var target = _get_building_map().get_closest_building(global_position, "Castle")["position"]
		_state_machine.change_to("Navigating", {"target": target})

func _is_base_in_range():
	return _get_building_map().get_closest_building(global_position, "Castle")["distance"] < _deposit_range
	
	
func _get_building_map() -> BuildingGrid:
	return _parent._navigation.get_node("Buildings") as BuildingGrid
