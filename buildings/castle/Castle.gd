extends Building
class_name Castle

func _ready():
	add_to_group("Castle")
	health = 15
	cost = {"wood": 50, "stone": 100}
	
	$Vision.disable()
	
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	
	connect("input_event", self, "_on_input_event")	

func on_placed():
	$Vision.enable()

func set_resources(resources: ResourceManager):
	$UnitController.resources = resources

func get_unit_controller() -> UnitController:
	return get_node("UnitController") as UnitController

func get_collision_rectangle() -> Array:
	var collider: CollisionShape2D = $Collider
	return [collider.position, collider.shape.extents]
	
func _on_input_event(viewport: Object, event: InputEvent, shape_idx: int):
	if event.is_action("primary_action"):
		GlobalMediator.action("building_selected", [self])
	
func _on_mouse_exited():
	modulate_normal()

func _on_mouse_entered():
	var color = Color.blue
	color.a = 0.5
	modulate = color
