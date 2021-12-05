extends Node2D

signal fog_patch_removed(position)

func _on_Area2D_area_entered(area):
	if area.is_in_group("unit_vision") and area.owner.is_in_group("player"):
		queue_free()
		emit_signal("fog_patch_removed", position)
