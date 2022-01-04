class_name KinematicSeek

signal target_reached()

var final_node_satisfaction_radius = 64

var _character: Node2D
var _max_speed: float
var _target: Vector2

var _node_satisfaction_radius = 32
var _satisfaction_radius: float
var _target_was_reached := false

func init(character: Node2D, target: Vector2, max_speed: float):
	_character = character
	_target = target
	_max_speed = max_speed

func set_target(target: Vector2, final_target: bool = false):
	_target_was_reached = false
	_target = target
	if final_target:
		_satisfaction_radius = final_node_satisfaction_radius
	else:
		_satisfaction_radius = _node_satisfaction_radius

func _getSteering() -> SteeringOutput:
	var steering = SteeringOutput.new()
	
	var velocity: Vector2 = (_target - _character.global_position).normalized() * _max_speed
	if (_target - _character.global_position).length() > _satisfaction_radius:
		steering.linearVelocity = velocity.normalized() * clamp(velocity.length(), -_max_speed, _max_speed)
	else:
		steering.linearVelocity = Vector2.ZERO
		if not _target_was_reached:
			_target_was_reached = true
			emit_signal("target_reached")


	return steering
