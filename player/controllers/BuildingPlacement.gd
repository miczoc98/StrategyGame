class_name BuildingPlacement
extends PlayerController

var map: Map
var resources: ResourceManager

var _is_building_mode_on := false
var _current_building: Building
var _can_be_placed := false

var _current_castle: Castle

func init():
	mediator.subscribe("castle_selected", funcref(self, "_on_castle_selected"))
	mediator.subscribe("building_selected", funcref(self, "_on_building_selected"))

	_init_existing_buildings()


func _process(_delta):
	if _is_building_mode_on:
		var cell_to_place_building = map.building_grid.get_closest_cell(get_global_mouse_position())
		_current_building.global_position = map.building_grid.get_closest_cell_position(get_global_mouse_position())
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


func _init_existing_buildings():
	var player_buildings = get_tree().get_nodes_in_group("building")
	player_buildings = Nodes.filter_by_group(player_buildings, "player")
	for building in player_buildings:
		_init_building(building)


func _can_building_be_placed(cell) -> bool:
	return not _current_building.test_move(_current_building.global_transform, Vector2.ZERO)\
		and not map.fog_map.is_fogged(cell)


func _enough_resources() -> bool:
	return resources.has_enough_resources(_current_building.cost)


func _place_building():
	_is_building_mode_on = false
	_current_building.add_to_group("player")
	_current_building.add_to_group("building")
	
	_init_building(_current_building)
	
	remove_child(_current_building)
	if _current_building is Castle:
		map.building_grid.place_building(_current_building)
	else:
		map.building_grid.place_building(_current_building, _current_castle)
	
	resources.pay_resources(_current_building.cost)


func _init_building(building: Building):
	if building is Castle:
		building.map = map
	
	building.init()

func _on_building_selected(building):
	if _current_castle == null and not building is Castle:
		return
	
	_current_building = building
	add_child(_current_building)
	_is_building_mode_on = true


func _on_castle_selected(castle: Castle):
	_current_castle = castle
