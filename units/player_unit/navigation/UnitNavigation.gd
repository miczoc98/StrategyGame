class_name UnitNavigation
extends Node2D

signal new_path_generated(path)
signal target_reached()

var map: Map = null

var _max_speed := 40.00
var _max_speed_in_mountains = 20.0

var _behaviour: KinematicSeek = null
var _path_to_follow: PoolVector2Array = PoolVector2Array()


func _ready():
	_behaviour = KinematicSeek.new()
	_behaviour.init(self, self.global_position, _max_speed)
	_behaviour.connect("target_reached", self, "on_target_reached")

func get_steering() -> SteeringOutput:
	if _behaviour != null:
		return _behaviour._getSteering()
	else:
		return SteeringOutput.new()

func set_new_target(target: Vector2, tolerancy := 32.0) -> void:
	_path_to_follow = map.get_path_to_target(self.global_position, target)
	_behaviour.set_target(_path_to_follow[0])
	_behaviour.final_node_satisfaction_radius = tolerancy
	emit_signal("new_path_generated", _path_to_follow)
	

func on_target_reached():
	if _path_to_follow.size() == 1:
		_behaviour.set_target(_path_to_follow[0], true)
		_path_to_follow.remove(0)
	elif (_path_to_follow.size() > 1):
		_behaviour.set_target(_path_to_follow[0])
		_path_to_follow.remove(0)
	else:
		emit_signal("target_reached")

func _on_GroundTypeDetector_body_entered(body):
	if _is_mountain(body):
		_behaviour._max_speed = _max_speed_in_mountains
		
func _on_GroundTypeDetector_body_exited(body):
	if _is_mountain(body):
		_behaviour._max_speed = _max_speed
		
func _is_mountain(body: Node2D):
	return body is TileMap and body.collision_layer == 16
