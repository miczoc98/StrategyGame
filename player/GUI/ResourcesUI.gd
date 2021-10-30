extends CanvasLayer

onready var wood = $Panel/HBoxContainer/Wood
onready var stone = $Panel/HBoxContainer/Stone
onready var food = $Panel/HBoxContainer/Food

onready var labels = {"wood": wood, "stone": stone, "food": food}

func _on_Resources_resource_changed(type: String, amount: int):
	labels[type].text = type + ": " + str(amount)
