extends HSlider
class_name JobSlider

signal job_assignment_changed(job)

var _job: Job

func _init(job: Job):
	_job = job

func _ready():
	connect("value_changed", self, "_on_value_changed")
	
func _on_value_changed(_value: int):
	emit_signal("job_assignment_changed", _job)
	
