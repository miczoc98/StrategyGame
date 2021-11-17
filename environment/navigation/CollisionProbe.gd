class_name CollisionProbe
extends Node2D

var offset_distance := 32
var collision_mask = 0;
	
func is_raycast_clear(from: Vector2, to: Vector2) -> bool:
	var collisions1 := _cast_with_offset(from, to, 0.5)
	var collisions2 := _cast_with_offset(from, to, -0.5)
	
	var is_not_colliding = collisions1.empty() and collisions2.empty()
	return is_not_colliding

func set_collision_mask(mask: int):
	collision_mask = mask
	

func _cast_with_offset(from: Vector2, to: Vector2, offset_direction: float) -> Dictionary:	
	var offset = (to - from).rotated(offset_direction).normalized() * offset_distance
	return get_world_2d().direct_space_state.intersect_ray(from + offset, to + offset, [], collision_mask)
