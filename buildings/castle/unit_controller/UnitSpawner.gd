extends Node2D

onready var unit_prefab = preload("res://units/player_unit/Unit2D.tscn")

var map: Map

func init():
	for unit in get_children():
		_set_unit_up(unit)

func spawn_unit():
	var unit = unit_prefab.instance()
	add_child(unit)

	_set_unit_up(unit)
	
	return unit

func _set_unit_up(unit: Unit2D):
	unit.map = map
	unit.owner_position = global_position
	unit.init()
	
	GlobalMediator.action("unit_spawned", [unit])
