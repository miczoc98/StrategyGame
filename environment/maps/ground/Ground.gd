extends TileMap

var water_material = preload("res://environment/maps/ground/water_material.tres")


func _ready():
	var texture_size = tile_set.tile_get_texture(2).get_size()
	var region = tile_set.tile_get_region(2)
#
	var region_position = region.position / texture_size
	var region_size = region.size / texture_size 
#
#
	water_material.set_shader_param("region_position", region_position)
	water_material.set_shader_param("region_size", region_size)
	
	tile_set.tile_set_material(2, water_material)
