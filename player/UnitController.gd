extends Node2D

signal unit_selected(unit)

var target := load("res://Target.tscn")
var targetInstance: Node2D = null

var unit_under_cursor: Unit2D
var active_unit: Unit2D

func _ready():
	var units = get_tree().get_nodes_in_group("player_unit")
	for unit in units:
		subscribe_to_unit_events(unit)

func _process(delta):
	if (Input.is_action_just_pressed("secondary_action")):
		set_target_for_active_unit(get_global_mouse_position())
	if (Input.is_action_just_pressed("primary_action")):
		select_active_unit(unit_under_cursor)


func set_target_for_active_unit(mousePosition: Vector2):
	if active_unit == null:
		return
	
	active_unit.set_target(mousePosition)

func select_active_unit(unit: Unit2D):
	active_unit = unit
	emit_signal("unit_selected", unit)
	
func subscribe_to_unit_events(unit: Unit2D):
	unit.connect("unit_mouse_entered", self, "_on_Unit2D_unit_mouse_entered")
	unit.connect("unit_mouse_exited", self, "_on_Unit2D_unit_mouse_exited")

func _on_Unit2D_unit_mouse_entered(unit):
	unit_under_cursor = unit

func _on_Unit2D_unit_mouse_exited(unit):
	if unit == unit_under_cursor:
		unit_under_cursor = null
