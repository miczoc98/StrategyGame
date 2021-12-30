extends Node2D

signal unit_spawned(unit)

onready var unit_prefab = preload("res://unit/Unit2D.tscn")

func spawn_unit():
	var unit = unit_prefab.instance()
	get_parent().add_child(unit)
	emit_signal("unit_spawned", unit)
