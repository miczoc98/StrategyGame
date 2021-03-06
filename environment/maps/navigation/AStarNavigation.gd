class_name AStarNavigation
extends Node2D

const WALKABLE_TILE_ID := 0

onready var _collision_probe: CollisionProbe = $CollisionProbe

var ground_map: TileMap
var mountain_map: TileMap
var tree_map: TileMap

var _Astar = AStar2D.new()

var _point_ids_by_position_in_tilemap := Dictionary()
var _last_id := 0

var _cell_size: Vector2


func init():
	_collision_probe.set_collision_mask(MaskCalculator.sum([2, 3, 4]))
	_cell_size = ground_map.cell_size

	var cells = ground_map.get_used_cells_by_id(WALKABLE_TILE_ID)

	for cell in cells:
		if (tree_map.get_cellv(cell) != -1):
			continue
			
		var weight = _calculate_weight(cell)
		var position = _get_cell_position(cell)
		
		_last_id += 1
		_Astar.add_point(_last_id, position, weight)
		_point_ids_by_position_in_tilemap[cell] = _last_id
	
	for cell in _point_ids_by_position_in_tilemap.keys():
		_create_neighbours_connections(cell)


func get_path_to_target(position: Vector2, target: Vector2):
	var path: Array = [position]
	
	var start_node = _Astar.get_closest_point(position)
	var end_node  = _Astar.get_closest_point(target)
	path.append_array(_Astar.get_point_path(start_node, end_node))
	
	path.append(target)
	return _optimize_path(path)


func add_node(cell_coordinates: Vector2) -> void:
	_last_id += 1
	_Astar.add_point(_last_id, _get_cell_position(position))
	_point_ids_by_position_in_tilemap[position] = _last_id
	_create_neighbours_connections(position)


func disable_nodes(cell_coordinates: Array) -> void:
	for cell in cell_coordinates:
		if _point_ids_by_position_in_tilemap.has(cell):
			_Astar.set_point_disabled(_point_ids_by_position_in_tilemap[cell])


func enable_nodes(cell_coordinates: Array) -> void:
	for cell in cell_coordinates:
		if _point_ids_by_position_in_tilemap.has(cell):
			_Astar.set_point_disabled(_point_ids_by_position_in_tilemap[cell], false)


func _calculate_weight(cell: Vector2) -> float:
	if (mountain_map.get_cellv(cell) != -1):
		return 2.0
	else:
		return 1.0


func _create_neighbours_connections(cell):
	var neighbour_cells = _get_neighbours(cell)
	
	for neighbour_cell in neighbour_cells:
		_connect_neighbour_if_exist(cell, neighbour_cell)


func _connect_neighbour_if_exist(cell: Vector2, neighbour_cell: Vector2):
	if (_point_ids_by_position_in_tilemap.has(neighbour_cell)):
		_Astar.connect_points(_point_ids_by_position_in_tilemap[neighbour_cell],
			_point_ids_by_position_in_tilemap[cell])


func _get_neighbours(cell: Vector2):
	var left_cell = Vector2(cell[0] - 1, cell[1])
	var right_cell = Vector2(cell[0] + 1, cell[1])
	var up_cell = Vector2(cell[0], cell[1] - 1)
	var down_cell = Vector2(cell[0], cell[1] + 1)
	
	return [left_cell, right_cell, up_cell, down_cell]


func _get_cell_position(cell: Vector2):
	return Vector2((cell.x + 0.5)* _cell_size.x, (cell.y + 0.5) * _cell_size.y)


func _optimize_path(path: Array) -> Array:
	if path.size() == 2:
		return path
	
	var output_path = [path[0]]
	var input_node_index = 2
	
	while input_node_index < path.size() - 1:
		var from = output_path[-1]
		var to = path[input_node_index]
		if not _collision_probe.is_raycast_clear(from, to):
			output_path.append(path[input_node_index - 1])
	
		input_node_index = input_node_index + 1
		
	output_path.append(path[-1])
	return output_path
