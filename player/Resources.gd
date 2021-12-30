class_name ResourceManager
extends PlayerController

signal resource_changed(type, amount) 
signal unit_count_changed(units, max_units)

var resources := {"wood": 100, "stone": 100, "food": 100}

var unit_limit = 10
var active_units = 0

var _unit_cost = {"food": 50}

func _ready():
	GlobalMediator.subscribe("resource_deposited", funcref(self, "_on_resource_deposited"))
	
	GlobalMediator.subscribe("house_placed", funcref(self, "_on_house_placed"))
	GlobalMediator.subscribe("house_destroyed", funcref(self, "_on_house_destroyed"))

	GlobalMediator.subscribe("unit_spawned", funcref(self, "_on_unit_spawned"))
	GlobalMediator.subscribe("unit_died", funcref(self, "_on_unit_died"))


func pay_resources(resources: Dictionary) -> void:
	for resource in resources:
		change_resource_amount(resource, -resources[resource])


func change_resource_amount(type: String, amount: int) -> void:
	if not type in resources.keys():
		return
	
	resources[type] += amount
	mediator.action("resource_changed", [type, resources[type]])

func has_enough_resources(resources: Dictionary):
	for resource in resources:
		if self.resources[resource] < resources[resource]:
			return false
	return true 

func can_spawn_unit():
	return has_enough_resources(_unit_cost)\
		and active_units < unit_limit


func _on_unit_spawned(unit):
	active_units += 1
	mediator.action("unit_count_changed", [active_units, unit_limit])


func _on_unit_died(unit):
	active_units -= 1
	mediator.action("unit_count_changed", [active_units, unit_limit])


func _on_resource_deposited(name: String, amount: int) -> void:
	change_resource_amount(name, amount)
	print("resource deposited")

func _on_house_placed():
	unit_limit += 5
	mediator.action("unit_count_changed", [active_units, unit_limit])
	
func _on_house_destroyed():
	unit_limit -= 5
	mediator.action("unit_count_changed", [active_units, unit_limit])
