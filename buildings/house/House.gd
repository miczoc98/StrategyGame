extends Building

func _ready():
	add_to_group("House")
	set_max_health(100)
	cost = {"wood": 50, "stone": 10}

func on_placed():
	GlobalMediator.action("house_placed", [])

func get_collision_rectangle() -> Array:
	return [$CollisionShape2D.position, $CollisionShape2D.shape.extents]
