extends Node2D


func _process(_delta):
	if Input.is_action_just_pressed("f"):
		GlobalMediator.action("resource_deposited", ["food", 100])
		GlobalMediator.action("resource_deposited", ["wood", 100])
		GlobalMediator.action("resource_deposited", ["stone", 100])
