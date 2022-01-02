extends PlayerController

var resources: ResourceManager 

var _unit_controller: UnitController = null


func init():
	mediator.subscribe("castle_selected", funcref(self, "_on_castle_selected"))
	mediator.subscribe("assignments_changed", funcref(self, "_on_assignments_changed"))
	mediator.subscribe("recruit", funcref(self, "_on_recruit"))


func _on_castle_selected(castle: Castle):
	_unit_controller = castle.get_unit_controller()
	var max_units = _unit_controller.get_unit_count()
	var assignments = _unit_controller.get_requested_assignment()
	
	_unit_controller.connect("number_of_units_changed", self, "_on_number_of_unit_changed")
	
	mediator.action("unit_controller_changed", [max_units, assignments])


func _on_assignments_changed(assignments: Dictionary):
	_unit_controller.set_assignments(assignments)


func _on_number_of_unit_changed(unit_count: int):
	mediator.action("unit_controller_number_of_unit_changed", [unit_count])


func _on_recruit():
	if _unit_controller != null and resources.can_spawn_unit():
		resources.pay_resources(resources.unit_cost)
		_unit_controller.spawn_unit()
