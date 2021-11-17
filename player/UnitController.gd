extends Node2D

signal number_of_units_changed(units)
signal unit_selected(unit)

var unit_under_cursor: Unit2D
var active_unit: Unit2D

var _units := []
var _unit_assignments := {}
var _requested_assignments :={}

func _ready():
	_units = get_tree().get_nodes_in_group("player_unit")
	for unit in _units:
		subscribe_to_unit_events(unit)
		
	emit_signal("number_of_units_changed", _units.size())

func _process(delta):
	if (Input.is_action_just_pressed("primary_action")):
		select_active_unit(unit_under_cursor)

func select_active_unit(unit: Unit2D):
	active_unit = unit
	emit_signal("unit_selected", unit)
	
func subscribe_to_unit_events(unit: Unit2D):
	unit.connect("unit_mouse_entered", self, "_on_Unit2D_unit_mouse_entered")
	unit.connect("unit_mouse_exited", self, "_on_Unit2D_unit_mouse_exited")
	unit.connect("job_changed", self, "_on_unit_job_changed")

func _on_Unit2D_unit_mouse_entered(unit):
	unit_under_cursor = unit

func _on_Unit2D_unit_mouse_exited(unit):
	if unit == unit_under_cursor:
		unit_under_cursor = null

func _on_unit_job_changed(new_job):
	var requested_jobs := {}
	for assignment in _requested_assignments:
		requested_jobs[assignment] = _requested_assignments[assignment] - _get_unit_assignments()[assignment] 
	for unit in _units:
		unit.set_requested_jobs(requested_jobs)
	
func _on_assignment_changed(requested_assignments: Dictionary):
	_requested_assignments = requested_assignments
	
	var requested_jobs := {}
	for assignment in requested_assignments:
		requested_jobs[assignment] = _requested_assignments[assignment] - _get_unit_assignments()[assignment] 
	for unit in _units:
		unit.set_requested_jobs(requested_jobs)

func _get_unit_assignments() -> Dictionary:
	var unit_assignments = {}
	for job in Jobs.get_jobs():
		unit_assignments[job.name] = 0
	for unit in _units:
		if unit_assignments.has(unit.get_job()):
			unit_assignments[unit.get_job()] += 1
	return unit_assignments
