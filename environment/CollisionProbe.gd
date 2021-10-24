class_name CollisionProbe
extends Node2D

onready var raycast1 = $RayCast1
onready var raycast2 = $RayCast2

var offset_distance := 32

func is_raycast_clear(from: Vector2, to: Vector2) -> bool:
	_cast_with_offset(raycast1, from, to, 0.5)
	_cast_with_offset(raycast2, from, to, -0.5)
	
	var is_colliding = raycast1.is_colliding() or raycast1.is_colliding()
	return not is_colliding

func set_collision_mask(mask: int):
	raycast1.collision_mask = mask
	raycast2.collision_mask = mask 

func _cast_with_offset(raycast: RayCast2D, from: Vector2, to: Vector2, offset_direction: float):
	var offset = (to - from).rotated(offset_direction).normalized() * offset_distance
	
	raycast.position = from + offset
	raycast.cast_to = (to + offset) - raycast.position
	
	raycast.force_raycast_update()
