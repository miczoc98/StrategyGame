extends Node2D

onready var stats = $Statistics
onready var nav = $Navigation

func _ready():
	nav.nav = $"/root/Environment/Navigation"
	
	$StateMachine.start()

func order_move(target: Vector2):
	$StateMachine.change_to("Navigating", {"target": target})

func take_damage(amount: int):
	stats.take_damage(amount)

func _on_died():
	queue_free()


func _on_vision_enemy_detected():
	$StateMachine.change_to("Combat")
