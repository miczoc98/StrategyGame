extends PlayerGUI

onready var stat_panel: GridContainer = $Background/Panel

func _ready():
	yield(get_tree().get_nodes_in_group("player_controller")[0], "ready")
	
	mediator.subscribe("unit_selected", funcref(self, "_on_unit_selected"))

func _display_labels(unit: Unit2D):
	stat_panel.add_child(_create_label(unit.stats.unit_name, Label.ALIGN_CENTER))
	stat_panel.add_child(_create_label("", Label.ALIGN_CENTER))
	
	for stat_name in unit.stats.stats.keys():
		var label = _create_label(stat_name + ": " + str(unit.stats.stats[stat_name]), Label.ALIGN_LEFT)
		stat_panel.add_child(label)


func _remove_labels():
	for label in stat_panel.get_children():
		label.free()


func _create_label(text: String, alignment: int):
	var label: Label = Label.new()
	label.get_font("", "").height = 20
	label.align = alignment
	label.text = text
	return label


func _on_unit_selected(unit):
	_remove_labels()
	if (unit != null):
		_display_labels(unit)
