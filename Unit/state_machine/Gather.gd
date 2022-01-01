extends State

signal resource_gathered(type, amount)

onready var _timer: Timer = $Timer

var _gathering_range = 100
var _current_resource: Gatherable
var _resource_map: TileMapWithResources


func enter(msg: Dictionary = {}) -> void:
	if "resource" in msg:
		var resource = msg.resource
		_current_resource = resource
		_resource_map = _parent._navigation.get_node(resource.map)

func exit() -> void:
	_timer.stop()

func process(_delta: float) -> void:
	if _is_resource_in_range():
		_start_timer(1)
	else:
		var closest_resource_tile = _resource_map.get_closest_tile(global_position).world_position
		_timer.stop()
		_state_machine.change_to("Navigating", {"target": closest_resource_tile})

func _is_resource_in_range():
	if _resource_map == null:
		return false
	
	return _resource_map.get_closest_tile(global_position)["distance"] <= _gathering_range

func _start_timer(time: float) -> void:
	if _timer.is_stopped():
		_timer.start(time)

func _gather() -> void:
	var tile_to_gather = _resource_map.get_closest_tile(global_position)["position"]
	_resource_map.gather(tile_to_gather)
	emit_signal("resource_gathered", _current_resource.type, 10)
	
func _on_Timer_timeout() -> void:
	_gather()
