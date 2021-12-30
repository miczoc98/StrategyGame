extends Node2D
class_name Player

onready var mediator: = $Mediator
onready var resources: = $Resources

func _ready():
	$Resources.mediator = mediator
	
	for GUI in $GUI.get_children():
		GUI.mediator = mediator
	
	for Controller in $Controllers.get_children():
		Controller.mediator = mediator
		Controller.player = self
