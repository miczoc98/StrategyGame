extends PlayerGUI


func init():
	GlobalMediator.subscribe("orb_status_changed", funcref(self, "_on_orb_status_changed"))


func _on_orb_status_changed(orbs, all_orbs):
	$Panel/RichTextLabel.text = "Evil Orbs Destroyed: "\
		+ str(all_orbs - orbs) + "/" + str(all_orbs)
