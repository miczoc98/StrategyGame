extends PlayerController

var unit_under_cursor: Unit2D
var active_unit: Unit2D


func _ready():
	var units = get_tree().get_nodes_in_group("unit")
	units = Nodes.filter_by_group(units, "player")
	for unit in units:
		unit.connect("unit_mouse_entered", self, "_on_Unit2D_unit_mouse_entered") 
		unit.connect("unit_mouse_exited", self, "_on_Unit2D_unit_mouse_exited")
		
	GlobalMediator.subscribe("unit_spawned", funcref(self, "_on_unit_spawned"))
	

func _process(_delta):
	if (Input.is_action_just_pressed("primary_action")):
		_select_active_unit(unit_under_cursor)


func _on_unit_spawned(unit: Unit2D):
	unit.connect("unit_mouse_entered", self, "_on_Unit2D_unit_mouse_entered") 
	unit.connect("unit_mouse_exited", self, "_on_Unit2D_unit_mouse_exited")
	
	
func _select_active_unit(unit: Unit2D):
	active_unit = unit
	mediator.action("unit_selected", [unit])


func _on_Unit2D_unit_mouse_entered(unit):
	unit_under_cursor = unit


func _on_Unit2D_unit_mouse_exited(unit):
	if unit == unit_under_cursor:
		unit_under_cursor = null
