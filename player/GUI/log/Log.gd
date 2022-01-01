extends PlayerGUI

export var max_lines = 10
var text : String = ""

func _ready():
	GlobalMediator.subscribe("unit_job_changed", funcref(self, "_on_unit_job_changed"))

func _on_unit_job_changed(unit, new_job):
	text += unit + " changed job to: " + new_job + "\n"
	trim_text()
	$Panel/LogContent.text = text

func trim_text():
	while text.count("\n") > max_lines:
		var first_line_length = text.find("\n") + 1
		text.erase(0, first_line_length)
