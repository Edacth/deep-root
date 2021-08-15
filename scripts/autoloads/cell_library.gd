extends Node


enum ForegroundCells {
	EMPTY = -1
	GRASS = 2,
	DIRT = 3,
	STONE= 24,
	SMALL_TAPROOT = 23,
	COOKED_SMALL_TAPROOT = 25,
	REED_BULB = 20,
	
}

var foreground_dict: Dictionary
var foreground_tileset = load("res://assets/tilesets/foreground.tres")


func _ready() -> void:
	foreground_dict[ForegroundCells.EMPTY] = {"name": "Empty", "tags": [], "components": []}
	foreground_dict[ForegroundCells.GRASS] = {"name": "Grass", "tags": [], "components": []}
	foreground_dict[ForegroundCells.DIRT] = {"name": "Dirt", "tags": [], "components": []}
	foreground_dict[ForegroundCells.STONE] = {"name": "Stone", "tags": [], "components": []}
	foreground_dict[ForegroundCells.SMALL_TAPROOT] = {"name": "Small Taproot", "tags": [], "components": ["cookable"]}
	foreground_dict[ForegroundCells.COOKED_SMALL_TAPROOT] = {"name": "Cooked Small Taproot", "tags": [], "components": []}
	foreground_dict[ForegroundCells.REED_BULB] = {"name": "Reed Bulb", "tags": ["flammable"], "components": ["flammable"]}


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


func get_cell_uv_rect(cell_id: int):
	return foreground_tileset.tile_get_region(cell_id)


func get_cell_texture_offset(cell_id: int):
	return foreground_tileset.tile_get_texture_offset(cell_id)
