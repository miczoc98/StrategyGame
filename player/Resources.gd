class_name ResourceManager
extends Node2D

signal resource_changed(type, amount) 

var resources := {"wood": 100, "stone": 100, "food": 100}

func _ready():
	var units = get_tree().get_nodes_in_group("player_unit")
	for unit in units:
		unit.get_node("StateMachine/Gathering/Deposit").connect("resource_deposited", self, "_on_unit_resource_deposited")
	
func change_resource_amount(type: String, amount: int) -> void:
	if not type in resources.keys():
		return
	
	resources[type] += amount
	emit_signal("resource_changed", type, resources[type])


func _on_unit_resource_deposited(name: String, amount: int) -> void:
	change_resource_amount(name, amount)
	print("resource deposited")
