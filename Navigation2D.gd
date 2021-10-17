# This is extension of Navigation2D that provides pathing taking into account
# collider of the character

extends Navigation2D

onready var tile_map := $TileMap

# Returns path to target. If there is none available returns array with only @from.
func get_path_with_character_radius(from: Vector2, to: Vector2, radius: float) -> PoolVector2Array:
	var path = get_simple_path(from, to)
	for i in range(path.size()):
		var node = path[i]
		var colliding_tiles = get_colliding_tiles(node, radius)
		
		if (!colliding_tiles.empty()):
			var new_node = get_new_node_position(node, radius, colliding_tiles)
			
			if new_node != null:
				path[i] = new_node
			else:
				return PoolVector2Array([from])	
	
	return path


func get_new_node_position(node: Vector2, radius: float, tiles: Array) -> Object:
	var new_position = node
	
	for i in range(3):
		var collision = get_colliding_tiles(new_position, radius)[0]
		
		var displacement_direction: Vector2 = (node - collision).normalized()
		var collision_angle = displacement_direction.angle_to(Vector2.UP)
		var displacement_distance = abs(tile_map.cell_size.x/cos(collision_angle) - radius)
		
		new_position += displacement_direction * displacement_distance
		if get_colliding_tiles(new_position, radius).empty():
			break
	
	var line = Line2D.new()
	line.add_point(node)
	line.add_point(new_position)
	add_child(line)
	
	if (get_colliding_tiles(new_position, radius) == null):
		return new_position
	return null

func get_colliding_tiles(node: Vector2, radius: float):
	var starting_point = node + Vector2(-radius, -radius)
	var colliding_tiles := []
	
	while(starting_point.y < node.y + radius):
		while(starting_point.x < node.x + radius):
			print(point_to_tile_index(starting_point))
			var tile_at_point = tile_map.get_cellv(point_to_tile_index(starting_point))
			if (tile_at_point == 1):
				if ((get_tile_position(starting_point).distance_to(node)) < radius + sqrt(2) * tile_map.cell_size.x):
					colliding_tiles.append(get_tile_position(starting_point))
			starting_point.x += tile_map.cell_size.x
		starting_point.y += tile_map.cell_size.y
	
	return colliding_tiles
	

func get_tile_position(point: Vector2):
	var x = int(point.x)/tile_map.cell_size.x + tile_map.cell_size.x/2
	var y = int(point.y)/tile_map.cell_size.y + tile_map.cell_size.y/2
	return Vector2(x, y)	
	
func point_to_tile_index(point: Vector2):
	var x = int(point.x)/64 + 1
	var y = int(point.y)/64 + 1
	return Vector2(x, y)
