extends State

onready var navigation: UnitNavigation = owner.get_node("Navigation")
func _ready():
	navigation.connect("target_reached", self, "_on_target_reached")

func enter(msg := {}):
	navigation.set_new_target(msg.target)
	
func process(delta: float):
	owner.move_and_slide(navigation.get_steering().linearVelocity)
	
func _on_target_reached():
	_state_machine.back()
