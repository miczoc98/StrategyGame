class_name AStarNavigation
extends Node2D

var WALKABLE_CELLS_ID = 0

var Astar = AStar2D.new()

onready var ground_map: TileMap = $Ground
onready var tree_map: TileMap = $Trees
onready var mountain_map: TileMap = $Mountains
onready var collision_probe: CollisionProbe = $CollisionProbe

var point_ids_by_position_in_tilemap := Dictionary()
var last_id := 0

func _ready():
	collision_probe.set_collision_mask(MaskCalculator.sum([2]))
	
	var tiles = ground_map.get_used_cells_by_id(WALKABLE_CELLS_ID)

	for tile in tiles:
		if (tree_map.get_cellv(tile) != -1):
			continue
			
		var weight = _calculate_weight(tile)
		var position = _get_tile_position(tile)
		
		last_id = last_id + 1
		Astar.add_point(last_id, position, weight)
		point_ids_by_position_in_tilemap[tile] = last_id
	
	for tile in point_ids_by_position_in_tilemap.keys():
		_create_neighbours_connections(tile)

func _calculate_weight(tile: Vector2) -> float:
	if (mountain_map.get_cellv(tile) != -1):
		return 2.0
	else:
		return 1.0
	
func _create_neighbours_connections(tile):
	var neighbour_tiles = _get_neighbours(tile)
	
	for neighbour_tile in neighbour_tiles:
		_connect_neighbour_if_exist(tile, neighbour_tile)

func _connect_neighbour_if_exist(tile: Vector2, neighbour_tile: Vector2):
	if (point_ids_by_position_in_tilemap.has(neighbour_tile)):
		Astar.connect_points(point_ids_by_position_in_tilemap[neighbour_tile],
			point_ids_by_position_in_tilemap[tile])

func _get_neighbours(tile: Vector2):
	var left_tile = Vector2(tile[0] - 1, tile[1])
	var right_tile = Vector2(tile[0] + 1, tile[1])
	var up_tile = Vector2(tile[0], tile[1] - 1)
	var down_tile = Vector2(tile[0], tile[1] + 1)
	
	return [left_tile, right_tile, up_tile, down_tile]

func _get_tile_position(tile: Vector2):
	return Vector2((tile.x + 0.5)* ground_map.cell_size.x, (tile.y + 0.5) * ground_map.cell_size.y)

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
		if not collision_probe.is_raycast_clear(from, to):
			output_path.append(path[input_node_index - 1])
	
		input_node_index = input_node_index + 1
		
	output_path.append(path[-1])
	return output_path


func _on_Trees_tree_destroyed(position):
	last_id = last_id + 1
	Astar.add_point(last_id, _get_tile_position(position))
	point_ids_by_position_in_tilemap[position] = last_id
	_create_neighbours_connections(position)
