extends PlayerGUI

onready var wood = $Panel/HBoxContainer/Wood
onready var stone = $Panel/HBoxContainer/Stone
onready var food = $Panel/HBoxContainer/Food
onready var units = $Panel/HBoxContainer/UnitCount

onready var labels = {"wood": wood, "stone": stone, "food": food}

func _ready():
	yield(get_tree().get_nodes_in_group("player_controller")[0], "ready")
	
	mediator.subscribe("resource_changed", funcref(self, "_on_resource_changed"))
	mediator.subscribe("unit_count_changed", funcref(self, "_on_unit_count_changed"))

func _on_resource_changed(type: String, amount: int):
	labels[type].text = type + ": " + str(amount)

func _on_unit_count_changed(unit_count: int, max_units: int):
	self.units.text = "Available units: " + str(unit_count) + "/" + str(max_units)
