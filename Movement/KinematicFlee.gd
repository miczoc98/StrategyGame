class_name KinematicFlee extends KinematicBehaviour

var _character: Node2D


func init(character: Node2D, target: Vector2, max_speed: float) -> void:
	_character = character
	_target = target
	_max_speed = max_speed


func _getSteering() -> SteeringOutput:
	var steering = SteeringOutput.new()
	
	var direction: Vector2= -(_target - _character.position).normalized()
	steering.linearVelocity = direction * _max_speed

	return steering
