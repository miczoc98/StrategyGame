extends Node2D
class_name Player

onready var mediator := $Mediator
onready var resources := $Resources

var map: Map

func init():
	$Resources.mediator = mediator
	
	for GUI in $GUI.get_children():
		GUI.mediator = mediator
		GUI.init()
	
	$Controllers/UnitAssignment.resources = resources
	
	$Controllers/BuildingPlacement.map = map
	$Controllers/BuildingPlacement.resources = resources
	
	for controller in $Controllers.get_children():
		controller.mediator = mediator
		controller.init()
	
	
