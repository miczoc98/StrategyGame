extends Node2D

onready var building_grid: BuildingGrid = $"/root/Environment/Navigation/Buildings"
onready var resources: ResourceManager = $"../Resources"

var is_building_mode_on := false
var current_building: Building
var can_be_placed := false

func _on_BuildingMode_building_selected(building):	
	current_building = building
	add_child(current_building)
	is_building_mode_on = true
	
func _process(delta):
	if is_building_mode_on:
		current_building.position = building_grid.get_closest_cell_position(get_global_mouse_position())
		if current_building.test_move(current_building.transform, Vector2.ZERO):
			current_building.modulate_red()
			can_be_placed = false
		else:
			current_building.modulate_normal()
			can_be_placed = true
			
		if Input.is_action_just_pressed("primary_action") and can_be_placed and _enough_resources():
			remove_child(current_building)
			building_grid.place_building(current_building)
			is_building_mode_on = false
			for resource in current_building.cost.keys():
				resources.change_resource_amount(resource, -current_building.cost[resource])
		if Input.is_action_just_pressed("secondary_action"):
			is_building_mode_on = false
			remove_child(current_building)
			current_building.queue_free()
			
func _enough_resources() -> bool:
	for resource in current_building.cost.keys():
		if current_building.cost[resource] > resources.resources[resource]:
			return false
	
	return true
