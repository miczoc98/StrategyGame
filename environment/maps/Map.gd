class_name Map
extends Node2D

onready var fog_map: Fog = $Fog
onready var ground_map: TileMap = $Ground
onready var tree_map: TileMap = $Trees
onready var mountain_map: TileMap = $Mountains
onready var building_grid: BuildingGrid = $Buildings

onready var navigation: AStarNavigation = $Navigation

func init():
	building_grid.connect("object_destroyed", self, "_on_buildings_object_destroyed")
	building_grid.connect("object_placed", self, "_on_buildings_object_placed")
	building_grid.init()
	
	tree_map.connect("tree_destroyed", self, "_on_tree_destroyed")
	
	fog_map.ground_map = ground_map
	fog_map.init()
	
	navigation.ground_map = ground_map
	navigation.tree_map = tree_map
	navigation.mountain_map = mountain_map
	navigation.init()

func get_bounding_box():
	return ground_map.get_used_rect()


func get_path_to_target(position: Vector2, target: Vector2):
	return navigation.get_path_to_target(position, target)


func _on_tree_destroyed(position):
	navigation.add_node(position)


func _on_buildings_object_placed(collision_cells):
	navigation.disable_nodes(collision_cells)
	

func _on_buildings_object_destroyed(collision_cells):
	navigation.enable_nodes(collision_cells)
