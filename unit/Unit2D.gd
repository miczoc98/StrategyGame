extends KinematicBody2D
class_name Unit2D

signal unit_mouse_entered(unit)
signal unit_mouse_exited(unit)
signal unit_died(unit)

onready var navigation: UnitNavigation = $Navigation
onready var stats: Statistics = $Statistics

func _ready():
	navigation.nav = $"/root/Environment/Navigation"
	
func _physics_process(delta):
	move_and_slide(navigation.get_steering().linearVelocity)

func set_target(target: Vector2):
	navigation.set_new_target(target)

func take_damage(amount: int):
	stats.take_damage(amount)

func _on_Unit2D_mouse_entered():
	emit_signal("unit_mouse_entered", self)

func _on_Unit2D_mouse_exited():
	emit_signal("unit_mouse_exited", self)

func _on_died():
	emit_signal("unit_died", self)
	queue_free()