extends Control

onready var statistics: Statistics = $"../Statistics" 
onready var UIPanel: GridContainer = $"Background/Panel"

func _ready():
	$"..".connect("unit_selected", self, "on_unit_selected")
	
	UIPanel.add_child(create_label(statistics.unit_name))
	
	for stat_name in statistics.stats.keys():
		UIPanel.add_child(create_label(stat_name + ": " + str(statistics.stats[stat_name])))
	
	$Background.margin_top = UIPanel.margin_top
func on_unit_selected(is_selected: bool):
	visible = is_selected

func create_label(text: String):
	var label: Label = Label.new()
	label.text = text
	return label

