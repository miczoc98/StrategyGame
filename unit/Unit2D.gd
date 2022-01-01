extends KinematicBody2D
class_name Unit2D

signal unit_mouse_entered(unit)
signal unit_mouse_exited(unit)

signal unit_died(unit)
signal job_changed(unit, job)

onready var navigation: UnitNavigation = $Navigation
onready var stats: Statistics = $Statistics
onready var job: UnitJob = $Job

var owner_castle: Castle

func _ready():
	navigation.nav = $"/root/Environment/Navigation"
#
	$StateMachine.start()
	_propagate_groups()


func take_damage(amount: int):
	stats.take_damage(amount)

func set_requested_jobs(jobs: Dictionary):
	job.update_requested_jobs(jobs)

func get_job():
	return job._current_job;

func order_move(pos: Vector2):
	$StateMachine.change_to("Navigating", {"target": pos})


func _propagate_groups():
	for child in get_children():
		for group in get_groups():
			child.add_to_group(group)

func _on_vision_enemy_detected():
	$StateMachine.change_to("Combat")

func _on_job_changed(new_job):
	GlobalMediator.action("unit_job_changed", [stats.unit_name, new_job.name])
	emit_signal("job_changed", self)

func _on_Unit2D_mouse_entered():
	emit_signal("unit_mouse_entered", self)

func _on_Unit2D_mouse_exited():
	emit_signal("unit_mouse_exited", self)

func _on_died():
	GlobalMediator.action("unit_died")
	emit_signal("unit_died", self)
	queue_free()

