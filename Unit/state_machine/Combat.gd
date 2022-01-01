extends State


onready var damage: Damage = $Damage
onready var timer:Timer = $Timer
onready var stats:Statistics = owner.get_node("Statistics")
onready var vision:Vision = owner.get_node("Vision")


func _ready():
	$Damage.set_enemy_groups(GroupRelations.get_enemies(owner))

func process(_delta: float):
	var enemies_in_range = damage.get_enemies_in_range()
	if not enemies_in_range.empty():
		#owner.emit_signal("enemy_detected" , Nodes.get_closest_node(enemies_in_range, global_position).global_position)
		if (timer.is_stopped()):
			timer.start()
	else:
		timer.stop()
		var enemies = _get_visible_enemies()
		if enemies.empty():
			_state_machine.back()
		else:
			var closest_enemy = Nodes.get_closest_node(enemies, global_position)
			_state_machine.change_to("Navigating", {"target": closest_enemy.global_position, "tolerancy": 100, "timeout": 1})


func _get_visible_enemies():
	return vision.get_enemies_in_range()

func _calculate_damage():
	return 10 * stats.stats["fighting"] * 0.1


func _on_Timer_timeout():
	damage.deal_damage(_calculate_damage())



