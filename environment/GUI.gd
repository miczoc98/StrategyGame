extends Node2D

func _ready():
	yield(get_parent(), "ready")
