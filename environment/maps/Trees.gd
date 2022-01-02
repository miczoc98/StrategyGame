extends TileMapWithResources

signal tree_destroyed()

var tree_hps = Dictionary()

func _ready():
	for tile in tiles:
		tree_hps[tile] = 3

func gather(cell_vector: Vector2):
	if (get_cellv(cell_vector) != -1):
		tree_hps[cell_vector] -= 1
		if (tree_hps[cell_vector] == 0):
			destroy_tree(cell_vector)
		
func destroy_tree(cell_vector: Vector2):
	set_cellv(cell_vector, -1)
	tiles.erase(cell_vector)
	emit_signal("tree_destroyed", cell_vector)
