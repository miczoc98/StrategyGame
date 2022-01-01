extends Node2D

var children = []

func _ready():
	yield(get_tree(), "idle_frame")
	
	GlobalMediator.action("map_loaded")
