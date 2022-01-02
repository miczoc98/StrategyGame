class_name Attributes
extends Node2D

signal died()

var _max_health := 100.0
var _health := 100.0

var unit_name: String = ""
var stats := {}

func take_damage(amount: int):
	$HP.value = _health/_max_health
	_health -= amount
	_health = clamp(_health, 0, _max_health)
	if is_zero_approx(_health):
		_die()


func _die():
	emit_signal("died")
