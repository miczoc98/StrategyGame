extends PlayerGUI

onready var _unit_count_label = $Panel/VBoxContainer/UnitCount
onready var _slider_container = $Panel/VBoxContainer 
onready var _recruit_button = $Panel/VBoxContainer/RecruitButton

var _sliders_by_job := {}
var _max_units = 0


func init():
	_recruit_button.connect("button_down", self, "_on_recruit_button_down")
	
	mediator.subscribe("unit_controller_changed", funcref(self, "_on_unit_controller_changed"))
	mediator.subscribe("unit_controller_number_of_unit_changed", funcref(self, "_on_number_of_units_changed"))
	
	for job in Jobs.get_jobs():
		_create_job_slider(job)


func _create_job_slider(job: Job):
	var container = VBoxContainer.new()
	container.size_flags_vertical = container.SIZE_EXPAND | Control.SIZE_FILL
	container.size_flags_horizontal = container.SIZE_EXPAND | Control.SIZE_FILL
	var label = Label.new()
	label.text = job.name
	var slider = JobSlider.new(job)
	slider.max_value = _max_units
	slider.tick_count = _max_units + 1
	slider.ticks_on_borders = true
	slider.connect("job_assignment_changed", self, "_on_slider_job_assignment_changed")
	_sliders_by_job[job.name] = slider
	
	container.add_child(label)
	container.add_child(slider)
		
	_slider_container.add_child(container)


func _on_slider_job_assignment_changed(job: Job):
	_balance_sliders(_sliders_by_job[job.name])
	mediator.action("assignments_changed", [_calculate_assignments()])


func _balance_sliders(except: Slider):
	var sum = _calculate_sliders_value_sum()
	while sum > _max_units:
		for slider in _sliders_by_job.values():
			if slider == except:
				continue
			if slider.value >= 1:
				slider.set_value(slider.value - 1)
				sum -= 1


func _calculate_sliders_value_sum():
	var sum = 0
	for slider in _sliders_by_job.values():
		sum += slider.value
	return sum


func _calculate_assignments() -> Dictionary:
	var assignments = {}
	for job in _sliders_by_job.keys():
		assignments[job] = _sliders_by_job[job].value
	return assignments
	

func _on_unit_controller_changed(unit_count: int, assignments: Dictionary):
	for job in _sliders_by_job.keys():
		_sliders_by_job[job].max_value = unit_count
		_sliders_by_job[job].value = assignments[job]


func _on_number_of_units_changed(units):
	_max_units = units
	for slider in _sliders_by_job.values():
		slider.max_value = units

	_unit_count_label.text = "Available Units: " + str(units)


func _on_recruit_button_down():
	mediator.action("recruit")
