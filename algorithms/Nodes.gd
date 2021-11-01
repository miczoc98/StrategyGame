class_name Nodes

static func distance(node1: Node2D, node2: Node2D) -> float:
	return node1.global_position.distance_to(node2.global_position)

static func filter_by_group(nodes: Array, group: String) -> Array:
	var nodes_in_group  = []
	for node in nodes:
		if node.is_in_group(group):
			nodes_in_group.append(node)
	
	return nodes_in_group

static func get_closest_node(nodes: Array, position: Vector2) -> Node2D:
	var min_distance = INF
	var closest_node
	for node in nodes:
		if node.global_position.distance_to(position) < min_distance:
			closest_node = node
			
	return closest_node
