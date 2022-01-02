extends Node2D
class_name UnitController

signal number_of_units_changed(unit_count)

onready var _spawner = $UnitSpawner

var map: Map

var _units := []
var _unit_assignments := {}
var _requested_assignments :={}


func init():
	_spawner.map = map
	_spawner.init()
	
	_get_units()
	for unit in _units:
		_subscribe_to_unit_events(unit)

	for job in Jobs.get_jobs():
		_requested_assignments[job.name] = 0


func set_assignments(requested_assignments: Dictionary):
	_requested_assignments = requested_assignments
	
	var requested_jobs := {}
	for assignment in requested_assignments:
		requested_jobs[assignment] = _requested_assignments[assignment] - _get_unit_assignments()[assignment] 
	for unit in _units:
		unit.set_requested_jobs(requested_jobs)


func get_requested_assignment() -> Dictionary:
	return _requested_assignments


func get_unit_count() -> int:
	return _units.size()


func spawn_unit():
	var unit = _spawner.spawn_unit()
	
	_subscribe_to_unit_events(unit)
	_get_units()


func _subscribe_to_unit_events(unit):
	unit.connect("job_changed", self, "_on_unit_job_changed")
	unit.connect("unit_died", self, "_on_unit_died")
	unit.connect("enemy_detected", self, "_on_enemy_detected")


func _get_unit_assignments() -> Dictionary:
	var unit_assignments = {}
	for job in Jobs.get_jobs():
		unit_assignments[job.name] = 0
	for unit in _units:
		if unit_assignments.has(unit.get_job()):
			unit_assignments[unit.get_job()] += 1
	return unit_assignments


func _get_units():
	_units = _spawner.get_children()
	_units = Nodes.filter_by_group(_units, "unit")
	emit_signal("number_of_units_changed", _units.size())


func _on_unit_job_changed(_new_job):
	var requested_jobs := {}
	for assignment in _requested_assignments:
		requested_jobs[assignment] = _requested_assignments[assignment] - _get_unit_assignments()[assignment] 
	for unit in _units:
		unit.set_requested_jobs(requested_jobs)


func _on_unit_died(unit):
	_units.erase(unit)
	emit_signal("number_of_units_changed", _units.size())


func _on_enemy_detected(pos: Vector2):
	var exploring_units = _get_units_by_job("exploration")
	for unit in exploring_units:
		unit.order_move(pos)


func _get_units_by_job(job: String):
	var units_with_job = []
	
	for unit in _units:
		if unit.get_job() == job:
			units_with_job.append(unit)
	
	return units_with_job


func _on_building_enemy_detected(pos: Vector2):
	_on_enemy_detected(pos)
