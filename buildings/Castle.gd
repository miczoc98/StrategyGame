extends Building

signal castle_mouse_entered(building)
signal castle_mouse_exited(building)

func _ready():
	add_to_group("Castle")
	health = 15
	cost = {"wood": 50, "stone": 100}
	
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

func get_collision_rectangle() -> Array:
	var collider: CollisionShape2D = $Collider
	return [collider.position, collider.shape.extents]
