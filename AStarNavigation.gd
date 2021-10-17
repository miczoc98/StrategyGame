class_name AStarNavigation
extends Node2D

var WALKABLE_CELLS_ID = 0

var Astar = AStar2D.new()

onready var tilemap: TileMap = $TileMap
onready var collision_probe: RayCast2D = $CollisionProbe
var points_ids := Dictionary()


func _ready():
	collision_probe.collision_mask = 2
	
	var tiles = tilemap.get_used_cells_by_id(WALKABLE_CELLS_ID)
	
	var id = 0
	for tile in tiles:
		id = id + 1
		Astar.add_point(id, Vector2((tile.x + 0.5)* tilemap.cell_size.x, (tile.y + 0.5) * tilemap.cell_size.y))
		points_ids[tile] = id
	
	for tile in tiles:
		var left_tile = Vector2(tile[0] - 1, tile[1])
		var right_tile = Vector2(tile[0] + 1, tile[1])
		var up_tile = Vector2(tile[0], tile[1] - 1)
		var down_tile = Vector2(tile[0], tile[1] + 1)
		
		var left_up_tile = Vector2(tile[0] + 1, tile[1] - 1)
		var right_up_tile = Vector2(tile[0] - 1, tile[1] - 1)
		var left_down_tile = Vector2(tile[0] + 1, tile[1] + 1)
		var right_down_tile = Vector2(tile[0] - 1, tile[1] + 1)
		
		var neighbour_tiles = [left_tile, right_tile, up_tile, down_tile,
			left_up_tile, right_up_tile, left_down_tile, right_down_tile]
		
		for neighbour_tile in neighbour_tiles:
			if (points_ids.has(neighbour_tile)):
				Astar.connect_points(points_ids[neighbour_tile], points_ids[tile])
			

func get_path_to_target(position: Vector2, target: Vector2):
	var path: Array = [position]
	
	var start_node = Astar.get_closest_point(position)
	var end_node  = Astar.get_closest_point(target)
	path.append_array(Astar.get_point_path(start_node, end_node))
	
	path.append(target)
	return optimize_path(path)
	
func optimize_path(path: Array) -> Array:
	if path.size() == 2:
		return path
	
	var output_path = [path[0]]
	var input_node_index = 2
	
	while input_node_index < path.size() - 1:
		var from = output_path[-1]
		var to = path[input_node_index]
		if not is_raycast_clear(from, to):
			output_path.append(path[input_node_index - 1])
	
		input_node_index = input_node_index + 1
		
	output_path.append(path[-1])
	return output_path
	
	
func is_raycast_clear(from: Vector2, to: Vector2) -> bool:
	collision_probe.position = from
	var cast_to = to - from
	collision_probe.cast_to = cast_to
	collision_probe.force_raycast_update()
	return not collision_probe.is_colliding()
