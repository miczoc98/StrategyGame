extends KinematicBody2D
class_name Unit2D

signal unit_mouse_entered(unit)
signal unit_mouse_exited(unit)
signal unit_died(unit)
signal job_changed(unit, job)

onready var navigation: UnitNavigation = $Navigation
onready var stats: Statistics = $Statistics
onready var job: UnitJob = $Job

func _ready():
	navigation.nav = $"/root/Environment/Navigation"
	
func set_target(target: Vector2):
	navigation.set_new_target(target)

func take_damage(amount: int):
	stats.take_damage(amount)

func set_requested_jobs(jobs: Dictionary):
	print("requested jobs" + str(jobs))
	job.update_requested_jobs(jobs)

func get_job():
	return job._current_job;

func _on_job_changed(job):
	print(stats.unit_name + " changed job to " + job.name)
	emit_signal("job_changed", self)

func _on_Unit2D_mouse_entered():
	emit_signal("unit_mouse_entered", self)

func _on_Unit2D_mouse_exited():
	emit_signal("unit_mouse_exited", self)

func _on_died():
	emit_signal("unit_died", self)
	queue_free()

