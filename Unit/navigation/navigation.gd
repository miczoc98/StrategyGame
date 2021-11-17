class_name UnitNavigation
extends Node2D

signal new_path_generated(path)
signal target_reached()

var nav: AStarNavigation = null

var _max_speed := 100.0
var _max_speed_in_mountains = 50.0

var behaviour: KinematicBehaviour = null
var path_to_follow: PoolVector2Array = PoolVector2Array()

func _ready():
	behaviour = KinematicSeek.new()
	behaviour.init(self, self.global_position, _max_speed)
	behaviour.connect("target_reached", self, "on_target_reached")

func get_steering() -> SteeringOutput:
	if behaviour != null:
		return behaviour._getSteering()
	else:
		return SteeringOutput.new()

func set_new_target(target: Vector2) -> void:
	path_to_follow = nav.get_path_to_target(self.global_position, target)
	behaviour.set_target(path_to_follow[0])
	emit_signal("new_path_generated", path_to_follow)
	
func on_target_reached():
	if path_to_follow.size() == 1:
		behaviour.set_target(path_to_follow[0], true)
		path_to_follow.remove(0)
	elif (path_to_follow.size() > 1):
		behaviour.set_target(path_to_follow[0])
		path_to_follow.remove(0)
	else:
		emit_signal("target_reached")

func _on_GroundTypeDetector_body_entered(body):
	if _is_mountain(body):
		behaviour._max_speed = _max_speed_in_mountains
		
func _on_GroundTypeDetector_body_exited(body):
	if _is_mountain(body):
		behaviour._max_speed = _max_speed
		
func _is_mountain(body: Node2D):
	return body is TileMap and body.collision_layer == 4
