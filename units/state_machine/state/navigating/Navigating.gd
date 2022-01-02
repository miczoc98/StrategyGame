extends State

onready var navigation: UnitNavigation

var _time_between_stuck_checks := 2.0
var _last_saved_position: Vector2
var _stuck_radius := 5
var _is_stuck := false

func init():
	navigation.connect("target_reached", self, "_on_target_reached")


func enter(msg := {}):
	var target = global_position
	if msg.has("target"):
		target = msg["target"]
	
	if msg.has("tolerancy"):
		navigation.set_new_target(target, msg["tolerancy"])
	else:
		navigation.set_new_target(target)
		
	_last_saved_position = global_position
	_is_stuck = false
	$Timer.start()

	
func process(_delta: float):
	if _is_stuck:
		_state_machine.back()
	
	owner.move_and_slide(navigation.get_steering().linearVelocity)

	

func exit():
	$Timer.stop()


func _on_target_reached():
	_state_machine.back()


func _on_timeout():
	if global_position.distance_to(_last_saved_position) < _stuck_radius:
		_is_stuck = true
	else:
		_last_saved_position = global_position
	
