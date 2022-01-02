extends Node2D

onready var unit_prefab = preload("res://units/player_unit/Unit2D.tscn")

var map: Map

func spawn_unit():
	var unit = unit_prefab.instance()
	add_child(unit)
	
	unit.map = map
	unit.owner_position = global_position
	unit.init()

	return unit
