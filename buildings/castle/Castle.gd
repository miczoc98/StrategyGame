extends Building
class_name Castle

signal enemy_detected(position)

onready var _vision := $Vision
onready var _unit_controller := $UnitController

var map: Map

func _ready():
	add_to_group("Castle")
	set_max_health(500)
	cost = {"wood": 50, "stone": 100}
	
	GlobalMediator.subscribe("building_selected", funcref(self, "_on_building_selected"))
	
	_vision.disable()


func init():
	connect("input_event", self, "_on_input_event")
	
	_vision.enemy_groups = GroupRelations.get_enemies(self)
	_vision.enable()
	
	_unit_controller.map = map
	_unit_controller.init()


func add_building(building: Building):
	_subscribe_to_building_events(building)


func get_unit_controller() -> UnitController:
	return $UnitController as UnitController


func get_collision_rectangle() -> Array:
	var collider: CollisionShape2D = $Collider
	return [collider.position, collider.shape.extents]
	

func _on_vision_enemy_detected(pos):
	emit_signal("enemy_detected", pos)


func _subscribe_to_building_events(building: Building):
	if building.has_signal("enemy_detected"):
		building.connect("enemy_detected", self, "_on_vision_enemy_detected")


func _on_input_event(_viewport: Object, event: InputEvent, _shape_idx: int):
	if event.is_action("primary_action"):
		_set_active()
		GlobalMediator.action("building_selected", [self])


func _on_building_selected(building):
	if building != self:
		_set_inactive()


func _set_active():
	material.set_shader_param("is_active", true)


func _set_inactive():
	material.set_shader_param("is_active", false)
