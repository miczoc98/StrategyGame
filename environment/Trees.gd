extends TileMap

signal tree_destroyed(position)

var TREE_CELL_ID := 3

var tiles = get_used_cells_by_id(TREE_CELL_ID)
var tree_hps = Dictionary()

func _ready():
	for tile in tiles:
		tree_hps[tile] = 3

func _process(delta):
	if(Input.is_action_just_pressed("primary_action")):
		var position = get_global_mouse_position()
		var cell_vector = Vector2(int(position.x)/64, int(position.y)/64)
		
		if (get_cellv(cell_vector) != -1):
			tree_hps[cell_vector] -= 1
			if (tree_hps[cell_vector] == 0):
				destroy_tree(cell_vector)
		
func destroy_tree(cell_vector: Vector2):
	set_cellv(cell_vector, -1)
	emit_signal("tree_destroyed", cell_vector)
