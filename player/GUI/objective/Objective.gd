extends PlayerGUI

func _ready():
	yield(get_tree().get_nodes_in_group("player_controller")[0], "ready")
	GlobalMediator.subscribe("orb_status_changed", funcref(self, "_on_orb_status_changed"))
	
	var orb_count = GameController.get_orb_count()
	_on_orb_status_changed(0, orb_count)


func _on_orb_status_changed(orbs, all_orbs):
	$Panel/RichTextLabel.text = "Evil Orbs Destroyed: "\
		+ str(orbs) + "/" + str(all_orbs)
