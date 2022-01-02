extends TileMapWithResources

var BUSH_WITH_BERRIES_TILE_ID = 6
var BUSH_WITHOUT_BERRIES_TILE_ID = 7

var food_by_tile = {}

var tiles_to_renew_stack = []

func _ready():
	tiles = get_used_cells_by_id(BUSH_WITH_BERRIES_TILE_ID)
	for tile in tiles:
		food_by_tile[tile] = 10

func gather(tile: Vector2) -> void:
	food_by_tile[tile] -= 1
	if (food_by_tile[tile] <= 0):
		set_cellv(tile, BUSH_WITHOUT_BERRIES_TILE_ID)
		get_tree().create_timer(10).connect("timeout", self, "_renew_tile")
		tiles_to_renew_stack.push_front(tile)
		tiles.erase(tile)
	
func _renew_tile():
	var tile = tiles_to_renew_stack.pop_front()
	set_cellv(tile, BUSH_WITH_BERRIES_TILE_ID)
	tiles.append(tile)
	food_by_tile[tile] = 10

	
