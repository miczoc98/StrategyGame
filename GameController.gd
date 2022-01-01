extends Node2D

var _orbs := []
var _all_orbs_count

func _ready():
	_orbs = get_tree().get_nodes_in_group("evil_orb")
	for orb in _orbs:
		orb.connect("destroyed", self, "_on_orb_destroyed")
	_all_orbs_count = _orbs.size()

func get_orb_count():
	return _orbs.size()

func _on_orb_destroyed(orb):
	_orbs.erase(orb)
	GlobalMediator.action("orb_status_changed", [_orbs.size(), _all_orbs_count])
	if _orbs.empty():
		GlobalMediator.action("game_won")
