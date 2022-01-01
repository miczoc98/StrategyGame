extends Node2D

onready var unit_prefab = preload("res://neutral_units/NeutralUnit.tscn")

func spawn(number_of_units: int, target: Vector2):
	for _i in range(number_of_units):
		var unit = unit_prefab.instance()
		add_child(unit)
		unit.global_position = global_position
		unit.order_move(target)
		
