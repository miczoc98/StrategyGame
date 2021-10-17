extends Node

signal target_spawned(target)

var target := load("res://Target.tscn")
var targetInstance: Node2D = null

var is_mouse_pressed: bool = false;

func _process(delta):
	var position2D = get_viewport().get_mouse_position()
	
	if (Input.is_mouse_button_pressed(BUTTON_LEFT)):
		if (is_mouse_pressed == false):
			print(position2D)
			spawnOrMoveTarget(position2D)
		
		is_mouse_pressed = true
	else:
		is_mouse_pressed = false


func spawnOrMoveTarget(mousePosition: Vector2):
	if targetExists():
		moveTarget(mousePosition)
	else:
		spawnTarget(mousePosition)

	emit_signal("target_spawned", targetInstance)
		
		
func targetExists():
	return targetInstance != null
	
func moveTarget(mousePosition: Vector2):
	targetInstance.position = mousePosition
	
func spawnTarget(mousePosition: Vector2):
	targetInstance = target.instance()
	add_child(targetInstance)
	moveTarget(mousePosition)

