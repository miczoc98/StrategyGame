extends PlayerController

var map: AStarNavigation
var resources: ResourceManager

var _is_building_mode_on := false

var _current_building: Building
var _can_be_placed := false

var _min_unfogged_quadrant_size = 2

func _ready():
	yield(get_tree().get_nodes_in_group("player_controller")[0], "ready")
	
	mediator.subscribe("building_selected", funcref(self, "_on_building_selected"))
	resources = player.resources
	map = get_tree().get_nodes_in_group("map")[0]


func _on_building_selected(building):	
	_current_building = building
	add_child(_current_building)
	_is_building_mode_on = true


func _process(_delta):
	if _is_building_mode_on:
		var cell_to_place_building = map.building_grid.get_closest_cell(get_global_mouse_position())
		_current_building.position = map.building_grid.get_closest_cell_position(get_global_mouse_position())
		if not _can_building_be_placed(cell_to_place_building):
			_current_building.modulate_red()
			_can_be_placed = false
		else:
			_current_building.modulate_normal()
			_can_be_placed = true
			
		if Input.is_action_just_pressed("primary_action") and _can_be_placed and _enough_resources():
			_place_building()
		if Input.is_action_just_pressed("secondary_action"):
			_is_building_mode_on = false
			remove_child(_current_building)
			_current_building.queue_free()


func _can_building_be_placed(cell) -> bool:
	return not _current_building.test_move(_current_building.transform, Vector2.ZERO)\
		and not map.fog_map.is_fogged(cell)


func _enough_resources() -> bool:
	return resources.has_enough_resources(_current_building.cost)


func _place_building():
	remove_child(_current_building)
	_is_building_mode_on = false
	_current_building.add_to_group("player")
	_current_building.add_to_group("building")
	
	_current_building.on_placed()
	map.building_grid.place_building(_current_building)
	resources.pay_resources(_current_building.cost)
