class_name KinematicSeek extends KinematicBehaviour

var _character: Node2D

var node_satisfaction_radius = 32
var final_node_satisfaction_radius = 64

var satisfaction_radius: float

var time_to_target_in_seconds := 0.25
var target_was_reached := false

func init(character: Node2D, target: Vector2, max_speed: float):
	_character = character
	_target = target
	_max_speed = max_speed

func set_target(target: Vector2, final_target: bool = false):
	target_was_reached = false
	_target = target
	if final_target:
		satisfaction_radius = final_node_satisfaction_radius
	else:
		satisfaction_radius = node_satisfaction_radius

func _getSteering() -> SteeringOutput:
	var steering = SteeringOutput.new()
	
	var velocity: Vector2 = (_target - _character.global_position).normalized() * _max_speed
	if (_target - _character.global_position).length() > satisfaction_radius:
		steering.linearVelocity = velocity.normalized() * clamp(velocity.length(), -_max_speed, _max_speed)
	else:
		steering.linearVelocity = Vector2.ZERO
		if not target_was_reached:
			target_was_reached = true
			emit_signal("target_reached")


	return steering
