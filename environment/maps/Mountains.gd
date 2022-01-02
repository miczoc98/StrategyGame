extends TileMapWithResources


var STONE_TILE_ID := 5
var MOUNTAIN_TILE_ID := 4

var stone_amount_by_tile := {}

func _ready():
	tiles = get_used_cells_by_id(STONE_TILE_ID)
	for tile in tiles:
		stone_amount_by_tile[tile] = 10
	
func gather(tile: Vector2) -> void:
	stone_amount_by_tile[tile] -= 1
	if (stone_amount_by_tile[tile] <= 0):
		set_cellv(tile, 4)
		tiles.erase(tile)

