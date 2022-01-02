extends State


onready var _damage: Damage = $Damage
onready var _timer:Timer = $Timer

var attributes:Attributes
var vision:Vision


func init():
	$Damage.set_enemy_groups(GroupRelations.get_enemies(owner))

func process(_delta: float):
	var enemies_in_range = _damage.get_enemies_in_range()
	if not enemies_in_range.empty():
		if (_timer.is_stopped()):
			_timer.start()
	else:
		_timer.stop()
		var enemies = _get_visible_enemies()
		if enemies.empty():
			_state_machine.back()
		else:
			var closest_enemy = Nodes.get_closest_node(enemies, global_position)
			_state_machine.change_to("Navigating", {"target": closest_enemy.global_position, "tolerance": 48, "timeout": 1})


func _get_visible_enemies():
	return vision.get_enemies_in_range()

func _calculate_damage():
	return 10 * attributes.stats["fighting"] * 0.1


func _on_Timer_timeout():
	_damage.deal_damage(_calculate_damage())



