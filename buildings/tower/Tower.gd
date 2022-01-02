extends Building

signal enemy_detected(pos)

func _ready():
	set_max_health(200)
	cost = {"stone": 50, "wood": 10}

func init():
	$Timer.start()
	
	$Vision.enemy_groups = GroupRelations.get_enemies(self)
	$Vision.enable()
	
	$Damage.set_enemy_groups(GroupRelations.get_enemies(self))


func get_collision_rectangle() -> Array:
	return [$CollisionShape2D.position, $CollisionShape2D.shape.extents]

func _on_vision_enemy_detected(pos):
	emit_signal("enemy_detected", pos)


func _on_timer_timeout():
	$Damage.deal_damage(100)
