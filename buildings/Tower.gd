extends Building

func _ready():
	add_to_group("Tower")
	health = 10
	cost = {"stone": 50, "wood": 10}

func get_collision_rectangle() -> Array:
	return [$CollisionShape2D.position, $CollisionShape2D.shape.extents]
