class_name Building
extends KinematicBody2D

signal destroyed(object)

var health := 10
var building_progress := 0
onready var original_color = modulate

var cost := {"wood": 50, "stone": 50}

func _init():
	collision_layer = 4
	collision_mask = MaskCalculator.sum([1, 2, 3, 4])

func take_damage(damage: int):
	health -= damage
	if (health <= 0):
		emit_signal("destroyed", self)
		queue_free()

func modulate_red():
	modulate = Color.red;
	
func modulate_normal():
	modulate = original_color


# returns array of two Vector2s
# first is offset, second is shape
# should be overrided
func get_collision_rectangle() -> Array:
	print_debug("using abstract function")
	return []
