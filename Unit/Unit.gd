extends KinematicBody2D
class_name Unit2D

onready var navigation: UnitNavigation = $Navigation

func _ready():
	$"/root/Environment".connect("target_spawned", self, "on_target_spawned")
	navigation.nav = $"/root/Environment/Navigation"


func _physics_process(delta):
	move_and_slide(navigation.get_steering().linearVelocity)


func on_target_spawned(target: Node):
	navigation.set_new_target(target)
