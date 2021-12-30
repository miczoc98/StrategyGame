class_name Statistics
extends Node2D

signal died()

var _max_health := 100.0
var _health := 100.0

var unit_name: String = ""

func take_damage(amount: int):
	$HP.value = _health/_max_health
	_health -= amount
	if (_health <= 0):
		_die()


func _die():
	emit_signal("died")
