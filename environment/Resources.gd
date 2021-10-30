class_name ResourceManager
extends Node2D

signal resource_changed(type, amount) 

var resources := {"wood": 100, "stone": 100, "food": 100}

func change_resource_amount(type: String, amount: int) -> void:
	if not type in resources.keys():
		return
	
	resources[type] += amount
	emit_signal("resource_changed", type, resources[type])


func _on_Trees_tree_destroyed(position):
	change_resource_amount("wood", 20)
