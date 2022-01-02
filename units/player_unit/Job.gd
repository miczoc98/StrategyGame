extends Node2D
class_name UnitJob

signal job_changed(current_job)

export var job_change_willingness_time_multiplier = 1
export var job_change_willingness_skill_level_multiplier = 0.5
export var job_change_willingness_requested_amount_multiplier = 3

var attributes: Attributes

var _requested_jobs := {}
var _job_change_treshold = 50
var _last_job_change_time_in_ms: float
var _current_job := ""

func update_requested_jobs(requested_jobs: Dictionary):
	_requested_jobs = requested_jobs

func _on_job_change_timer_timeout():
	for requested_job in _requested_jobs:
		if _requested_jobs[requested_job] <= 0:
			continue
		if requested_job == _current_job:
			continue
		
		var job = Jobs.get_job(requested_job)
		var job_change_willingness = _calculate_job_change_willingness(job, _requested_jobs[requested_job])
		if job_change_willingness > _job_change_treshold:
			_change_job(job)


func _calculate_job_change_willingness(requested_job: Job, requested_number) -> float:
	var skill_level = 0
	if requested_job.associated_skill != "none":
		skill_level = attributes.stats[requested_job.associated_skill]
		
	var time_from_last_change =  OS.get_ticks_msec() - _last_job_change_time_in_ms
	
	return skill_level * job_change_willingness_skill_level_multiplier \
		+ (time_from_last_change/1000) * job_change_willingness_time_multiplier \
		+ requested_number * job_change_willingness_requested_amount_multiplier


func _change_job(job: Job) -> void:
	if job is GatheringJob:
		owner.get_node("StateMachine").change_to("Gathering", {"resource": Resources.get_resource(job.resource)})
	elif job is ExplorationJob:
		owner.get_node("StateMachine").change_to("Exploring")
	
	_last_job_change_time_in_ms = OS.get_ticks_msec()
	_current_job = job.name

	emit_signal("job_changed", job)
	
