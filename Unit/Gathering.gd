class_name Gathering
extends Node2D

signal resource_deposited(resource, amount)

onready var _navigation = $"/root/Environment/Navigation"
onready var _detector: Area2D = $Detector 
onready var _timer: Timer = $Timer

var _max_resources = 50
var _gathering_range = 100
var _deposit_range = 200
var _gathered_resources := {"wood": 0, "stone": 0, "food": 0}
var _current_resource: Gatherable
var _resource_map: TileMapWithResources


func _process(delta: float):
	if _is_base_in_range():
		for resource in _gathered_resources.keys():
			if (_gathered_resources[resource] > 0):
				emit_signal("resource_deposited", resource, _gathered_resources[resource])
				_gathered_resources[resource] = 0
	
	if _is_resource_in_range():
		_start_timer(1)
	else:
		_timer.stop()
	
	#ToDo: set automatically
	if (Input.is_key_pressed(KEY_1)):
		_set_gathering(Resources.get_resource("wood"))
		print("gathering wood")
	if (Input.is_key_pressed(KEY_2)):
		_set_gathering(Resources.get_resource("stone"))
		print("gathering stone")
	if (Input.is_key_pressed(KEY_3)):
		_set_gathering(Resources.get_resource("food"))
		print("gathering food")

func _is_base_in_range():
	return _navigation.get_node("Buildings").get_closest_building(global_position, "Castle")["distance"] < _deposit_range

func _is_resource_in_range():
	if _resource_map == null:
		return false
	
	return _resource_map.get_closest_tile(global_position)["distance"] <= _gathering_range

func _start_timer(time: float) -> void:
	if _timer.is_stopped():
		_timer.start(time)

func _set_gathering(resource: Gatherable) -> void:
	_current_resource = resource
	_set_layer(resource.layer)
	_resource_map = _navigation.get_node(resource.map)
	
func _set_layer(layer: int) -> void:
	_detector.collision_mask = layer
	
func _gather() -> void:
	var tile_to_gather = _resource_map.get_closest_tile(global_position)["position"]
	_resource_map.gather(tile_to_gather)
	_gathered_resources[_current_resource.type] += 10

	
func _on_Timer_timeout() -> void:
	_gather()
