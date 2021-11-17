extends CanvasLayer

#requested_assignment: Dictionary, keys are assignment types
signal assignments_changed(requested_assignment)

onready var _unit_count_label = $Panel/VBoxContainer/UnitCount
onready var _slider_container = $Panel/VBoxContainer 
var sliders_by_job := {}

var max_units = 10

func _ready():
	for job in Jobs.get_jobs():
		_create_job_slider(job)

func _create_job_slider(job: Job):
	var container = VBoxContainer.new()
	container.size_flags_vertical = container.SIZE_EXPAND | Control.SIZE_FILL
	container.size_flags_horizontal = container.SIZE_EXPAND | Control.SIZE_FILL
	var label = Label.new()
	label.text = job.name
	var slider = JobSlider.new(job)
	slider.max_value = max_units
	slider.tick_count = max_units + 1
	slider.ticks_on_borders = true
	slider.connect("job_assignment_changed", self, "_on_slider_job_assignment_changed")
	sliders_by_job[job.name] = slider
	
	container.add_child(label)
	container.add_child(slider)
		
	_slider_container.add_child(container)
	

func _balance_sliders(except: Slider):
	var sum = _calculate_sliders_value_sum()
	while sum > max_units:
		for slider in sliders_by_job.values():
			if slider == except:
				continue
			slider.set_value(slider.value - 1)
			sum -= 1
		
		
func _calculate_sliders_value_sum():
	var sum = 0
	for slider in sliders_by_job.values():
		sum += slider.value
	return sum

func _calculate_assignments() -> Dictionary:
	var assignments = {}
	for job in sliders_by_job.keys():
		assignments[job] = sliders_by_job[job].value
	return assignments

func _on_slider_job_assignment_changed(job: Job):
	_balance_sliders(sliders_by_job[job.name])
	emit_signal("assignments_changed", _calculate_assignments())

func _on_UnitController_number_of_units_changed(units):
	max_units = units
	for slider in sliders_by_job.values():
		slider.max_value = units

	_unit_count_label.text = "Available Units: " + str(units)
