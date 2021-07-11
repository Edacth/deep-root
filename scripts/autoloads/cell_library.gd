extends Node


enum ForegroundCells {
	EMPTY = -1
	GRASS = 2,
	DIRT = 3
}

var foreground_dict: Dictionary


func _ready() -> void:
	foreground_dict[ForegroundCells.EMPTY] = {"name": "Empty", "tags": []}
	foreground_dict[ForegroundCells.GRASS] = {"name": "Grass", "tags": ["breakable"]}
	foreground_dict[ForegroundCells.DIRT] = {"name": "Dirt", "tags": ["breakable"]}


func get_cell_data(cell_enum: int) -> Dictionary:
	if foreground_dict.has(cell_enum):
		return foreground_dict[cell_enum]
	else:
		return foreground_dict[ForegroundCells.EMPTY]


func has_tag(cell_enum: int, searched_tag) -> bool:
	if !foreground_dict.has(cell_enum): 
		return false
	for tag in foreground_dict[cell_enum].tags:
		if tag == searched_tag:
			return true
	return false
