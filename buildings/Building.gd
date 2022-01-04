class_name Building
extends KinematicBody2D

signal destroyed(object)

var health := 10.0 
var current_health := health

onready var original_color = modulate

var cost := {"wood": 50, "stone": 50}

func _init():
	collision_layer = MaskCalculator.sum([4])
	collision_mask = MaskCalculator.sum([2, 3, 4, 5, 6])


func set_max_health(max_health: float):
	health = max_health
	current_health = health

func take_damage(damage: float):
	$HP.value = current_health/health
	current_health -= damage
	if (current_health <= 0):
		emit_signal("destroyed", self)
		queue_free()


func modulate_red():
	modulate = Color.red;

	
func modulate_normal():
	modulate = original_color


# called when building is placed
# should be overrided
func init():
	print_debug("using abstract function")
	pass

# returns array of two Vector2s
# first is offset, second is shape
# should be overrided
func get_collision_rectangle() -> Array:
	print_debug("using abstract function")
	return [Vector2.ZERO, Vector2.ZERO]
