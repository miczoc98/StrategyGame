class_name UnitNavigation
extends Node2D

signal new_path_generated(path)
signal target_reached()

var nav: AStarNavigation = null

var castle: Castle
var _max_speed := 40.00
var _max_speed_in_mountains = 20.0

var behaviour: KinematicSeek = null
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

func set_new_target(target: Vector2, tolerancy := 64.0) -> void:
	path_to_follow = nav.get_path_to_target(self.global_position, target)
	behaviour.set_target(path_to_follow[0])
	behaviour.final_node_satisfaction_radius = tolerancy
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
