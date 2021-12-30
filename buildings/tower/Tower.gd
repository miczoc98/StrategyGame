extends Building

func _ready():
	add_to_group("Tower")
	health = 10
	cost = {"stone": 50, "wood": 10}

	$Damage.set_enemy_groups(GroupRelations.get_enemies(self))


func on_placed():
	$Timer.start()


func get_collision_rectangle() -> Array:
	return [$CollisionShape2D.position, $CollisionShape2D.shape.extents]


func _on_timer_timeout():
	$Damage.deal_damage(10)
