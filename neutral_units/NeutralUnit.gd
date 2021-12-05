extends Node2D

onready var stats = $Statistics
onready var nav = $Navigation

func _ready():
	nav.nav = $"/root/Environment/Navigation"
	
	$StateMachine.start()

func take_damage(amount: int):
	stats.take_damage(amount)

func _on_died():
	queue_free()
