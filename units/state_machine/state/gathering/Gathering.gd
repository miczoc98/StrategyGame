class_name Gathering
extends State

onready var navigation: Map

var _max_resources = 50
var _gathered_resources := {"wood": 0, "stone": 0, "food": 0}


func enter(msg: Dictionary = {}):
	_state_machine.change_to("Gathering/Gather", msg)
	
func _on_Gather_resource_gathered(type, amount):
	_gathered_resources[type] += amount
	if _gathered_resources[type] >= _max_resources:
		_state_machine.change_to("Gathering/Deposit")
