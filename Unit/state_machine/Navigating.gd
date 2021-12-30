extends State

onready var navigation: UnitNavigation = owner.get_node("Navigation")


func _ready():
	navigation.connect("target_reached", self, "_on_target_reached")


func enter(msg := {}):
	var target = global_position
	if msg.has("target"):
		target = msg["target"]
	
	if msg.has("timeout"):
		$Timer.start(msg["timeout"])
	
	if msg.has("tolerancy"):
		navigation.set_new_target(target, msg["tolerancy"])
	else:
		navigation.set_new_target(target)

	
func process(delta: float):
	owner.move_and_slide(navigation.get_steering().linearVelocity)


func exit():
	$Timer.stop()


func _on_target_reached():
	_state_machine.back()


func _on_timeout():
	_state_machine.back()
