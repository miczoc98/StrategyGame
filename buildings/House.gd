extends Building

func _ready():
	health = 5
	cost = {"wood": 50, "stone": 10}

func get_collision_rectangle() -> Array:
	return [$CollisionShape2D.position, $CollisionShape2D.shape.extents]
