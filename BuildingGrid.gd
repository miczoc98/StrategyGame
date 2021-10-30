class_name BuildingGrid
extends Node2D

export var grid_size := 64

signal object_placed(collision_cells)

func get_closest_cell_position(position: Vector2) -> Vector2:
	var cell_position_in_tilemap = get_closest_cell(position)
	return cell_position_in_tilemap * grid_size


func get_closest_cell(position: Vector2) -> Vector2:
	return Vector2(int(position.x)/grid_size, int(position.y)/grid_size)


func place_building(building: Building):
	add_child(building)
	var collider_shape = building.get_collision_rectangle()
	emit_signal("object_placed", _get_colliding_cells(building.position + collider_shape[0], collider_shape[1]))	

func _get_colliding_cells(offset: Vector2, shape: Vector2) -> Array:
	var colliding_cells = []  
	var bounding_box = [offset-shape, offset + shape]
	
	var current_position = bounding_box[0]
	while (current_position.x < bounding_box[1].x):
		current_position.y = bounding_box[0].y
		while (current_position.y < bounding_box[1].y):
			colliding_cells.append(get_closest_cell(current_position))
			current_position.y += grid_size
		current_position.x += grid_size
		
	return colliding_cells
