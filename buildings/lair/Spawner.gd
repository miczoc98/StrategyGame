extends Node2D

onready var unit_prefab = preload("res://units/neutral_unit/NeutralUnit.tscn")

var map: Map

func spawn(number_of_units: int, target: Vector2):
	for _i in range(number_of_units):
		var unit = unit_prefab.instance()
		add_child(unit)
		
		unit.map = map
		unit.global_position = global_position
		unit.init()
		
		unit.order_move(target)
		
