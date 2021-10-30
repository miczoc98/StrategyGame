extends CanvasLayer

signal building_selected(building)

func _ready():
	for icon in $Panel/HBoxContainer.get_children():
		icon.connect("building_selected", self, "on_building_selected")
		
func on_building_selected(building: Building) -> void:
	emit_signal("building_selected", building)
