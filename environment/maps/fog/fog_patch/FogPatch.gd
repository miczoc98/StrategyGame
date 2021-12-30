extends Node2D

signal fog_patch_removed(position)

func _set_position(position: Vector2):
	var shader_material: ShaderMaterial = $Sprite.material
	shader_material.set_shader_param("tile_coordinates", position)
	material = shader_material

func _on_Area2D_area_entered(area):
	if area.is_in_group("unit_vision") and area.owner.is_in_group("player"):
		queue_free()
		emit_signal("fog_patch_removed", position)
