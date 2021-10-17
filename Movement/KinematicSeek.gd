class_name KinematicSeek extends KinematicBehaviour

var _character: Node2D

var satisfaction_radius := 10
var time_to_target_in_seconds := 0.25

func init(character: Node2D, target: Vector2, max_speed: float):
	_character = character
	_target = target
	_max_speed = max_speed

func _getSteering() -> SteeringOutput:
	var steering = SteeringOutput.new()
	
	var velocity: Vector2 = (_target - _character.position)/time_to_target_in_seconds
	if velocity.length() > satisfaction_radius:
		steering.linearVelocity = velocity.normalized() * clamp(velocity.length(), -_max_speed, _max_speed)
	else:
		steering.linearVelocity = Vector2.ZERO
		emit_signal("target_reached")

	return steering
