extends Button

signal building_selected(object)

export(PackedScene) var building_scene

func _ready():
	var building:Building = building_scene.instance()
	icon = building.get_node("Sprite").texture

func _on_pressed():
	emit_signal("building_selected", building_scene.instance())
