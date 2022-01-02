extends Node2D

onready var _attributes = $Attributes
onready var _navigation = $Navigation

var map: Map

func init():
	_navigation.map = map
	
	$Vision.enemy_groups = GroupRelations.get_enemies(self)
	
	$StateMachine/Navigating.navigation = _navigation
	
	$StateMachine/Combat.attributes = _attributes
	$StateMachine/Combat.vision = $Vision
	
	$StateMachine.start()

func order_move(target: Vector2):
	$StateMachine.change_to("Navigating", {"target": target})

func take_damage(amount: int):
	_attributes.take_damage(amount)

func _on_died():
	queue_free()


func _on_vision_enemy_detected(_enemy_position):
	$StateMachine.change_to("Combat")
