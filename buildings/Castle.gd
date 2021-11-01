extends Building

func _ready():
	add_to_group("Castle")
	health = 15
	cost = {"wood": 50, "stone": 100}

func get_collision_rectangle() -> Array:
	var collider: CollisionShape2D = $Collider
	return [collider.position, collider.shape.extents]