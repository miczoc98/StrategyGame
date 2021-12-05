extends Node2D
class_name Fog

export var is_enabled = true

var _tile_size := 64
var _fog_patch = preload("res://tilemaps/fog/FogPatch.tscn")
var _tiles_with_fog = []

func _ready():
	if not is_enabled:
		return
	
	var ground_map = get_node("../Ground")
	for tile in ground_map.get_used_cells():
		_place_fog(tile)

func is_fogged(tile: Vector2):
	return _tiles_with_fog.has(tile)

func _place_fog(tile: Vector2):
	_tiles_with_fog.append(tile)
	
	var position = tile * _tile_size
	var fog_patch = _fog_patch.instance()
	add_child(fog_patch)
	fog_patch.position = position
	fog_patch.connect("fog_patch_removed", self, "_on_fog_patch_removed")
	
func _on_fog_patch_removed(position: Vector2):
	_tiles_with_fog.erase((position/64).round())
