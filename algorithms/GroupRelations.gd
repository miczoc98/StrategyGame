class_name GroupRelations


static func get_relations():
	return {
		"player": {"enemy": ["enemy", "neutral"]},
		"ai": {"enemy": ["player", "neutral"]},
		"neutral": {"enemy": ["player", "ai"]}
	}


static func get_relation_groups():
	return ["player", "ai", "neutral"]


static func get_enemies(node: Node) -> Array:
	var group = _get_affinity_group(node)
	if group != null: 
		return get_relations()[group]["enemy"]
	return []

static func _get_affinity_group(node: Node):
	var node_groups = node.get_groups()
	for group in node_groups:
		if group in get_relation_groups():
			return group
			
