class_name KinematicBehaviour

signal target_reached()

var _max_speed: float
var _target: Vector2

func _getSteering() -> SteeringOutput:
	printerr("Warning: Using abstract behaviour")
	return SteeringOutput.new()
