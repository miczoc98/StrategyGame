class_name Unit2D
extends KinematicBody2D


signal unit_died(unit)
signal job_changed(unit, job)
signal enemy_detected(pos)

onready var attributes: Attributes = $Attributes

onready var _navigation: UnitNavigation = $Navigation
onready var _job: UnitJob = $Job

var map: Map
var owner_position: Vector2

func init():
	connect("input_event", self, "_on_input_event")
	
	_navigation.map = map
	$Job.attributes = attributes
	
	$Vision.enemy_groups = GroupRelations.get_enemies(self)
	
	$StateMachine/Gathering.navigation = map
	$StateMachine/Gathering/Gather.skills = attributes.stats
	$StateMachine/Gathering/Deposit.deposit_location = owner_position
	
	$StateMachine/Exploring.fog_map = map.fog_map
	$StateMachine/Exploring._central_point = owner_position

	$StateMachine/Combat.attributes = attributes
	$StateMachine/Combat.vision = $Vision

	$StateMachine/Navigating.navigation = _navigation

	$StateMachine.start()
	_propagate_groups()


func take_damage(amount: int):
	attributes.take_damage(amount)


func set_requested_jobs(jobs: Dictionary):
	_job.update_requested_jobs(jobs)


func get_job():
	return _job._current_job;


func order_move(pos: Vector2):
	$StateMachine.change_to("Navigating", {"target": pos})


func _propagate_groups():
	for child in get_children():
		for group in get_groups():
			child.add_to_group(group)


func _on_vision_enemy_detected(pos):
	emit_signal("enemy_detected", pos)
	$StateMachine.change_to("Combat")


func _on_job_changed(new_job):
	GlobalMediator.action("unit_job_changed", [attributes.unit_name, new_job.name])
	emit_signal("job_changed", self)


func _on_died():
	GlobalMediator.action("unit_died")
	emit_signal("unit_died", self)
	queue_free()


func _on_input_event(_viewport: Object, event: InputEvent, _shape_idx: int):
	if event.is_action("primary_action"):
		GlobalMediator.action("unit_selected", [self])

