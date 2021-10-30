class_name Gathering
extends Node2D

enum GatheringMode{NONE, WOOD, STONE, FOOD}

export(int, "NONE", "WOOD", "STONE", "FOOD") var _current_gathering_mode = GatheringMode.NONE

var max_resources = 50
var gathered_resources := {"wood": 0, "stone": 0, "food": 0}


