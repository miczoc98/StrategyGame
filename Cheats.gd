extends Node2D


func _process(delta):
	if Input.is_action_just_pressed("f"):
		GlobalMediator.action("resource_deposited", ["food", 100])
