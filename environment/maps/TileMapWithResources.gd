class_name TileMapWithResources
extends TileMap

var tiles = get_used_cells()
onready var fog_of_war_map =  

# returns position and distance to closest tile as dictionary
# with keys "position" and "distance"
func get_closest_tile(position: Vector2) -> Dictionary:
	var min_distance = INF
	var min_distance_tile
	for tile in tiles:
		var distance = (position - _get_tile_center(tile)).length()
		if (distance < min_distance):
			min_distance = distance
			min_distance_tile = tile
	return {"position": min_distance_tile, "distance": min_distance, "world_position": _get_tile_center(min_distance_tile)}
	
func gather(tile_position: Vector2) -> void:
	print_debug("Using abstract method")

func _get_tile_center(tile: Vector2):
	return Vector2(tile.x + 0.5, tile.y + 0.5)*64	
