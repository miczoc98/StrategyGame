extends Building


func _ready():
	set_max_health(200)
	cost = {"stone": 50, "wood": 10}

func on_placed():
	$Timer.start()
	$Damage.set_enemy_groups(GroupRelations.get_enemies(self))


func get_collision_rectangle() -> Array:
	return [$CollisionShape2D.position, $CollisionShape2D.shape.extents]


func _on_timer_timeout():
	$Damage.deal_damage(10)
