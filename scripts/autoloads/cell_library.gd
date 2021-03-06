extends Node


enum ForegroundCells {
	EMPTY = -1
	GRASS = 2,
	DIRT = 3,
	STONE= 24,
	SMALL_TAPROOT = 23,
	COOKED_SMALL_TAPROOT = 25,
	REED_BULB = 20,
	REED_STEM = 21,
	TAPROOT_SHELL = 26,
	TAPROOT_STEM = 27,
	BUCKET = 28,
	LOOSE_STONE = 29,
	NAIL = 30,
	ORE = 31,
	LOOSE_ORE = 32,
	LOOSE_TAPROOT_SHELL = 33
}

var foreground_dict: Dictionary
var foreground_tileset = load("res://assets/tilesets/foreground.tres")
var LiquidType = load("res://scripts/liquid.gd").LiquidType


func _ready() -> void:
	foreground_dict[ForegroundCells.EMPTY] = {"name": "Empty", "tags": [], "components": []}
	foreground_dict[ForegroundCells.GRASS] = {"name": "Grass", "tags": [], "components": []}
	foreground_dict[ForegroundCells.DIRT] = {"name": "Dirt", "tags": [], "components": []}
	foreground_dict[ForegroundCells.STONE] = {"name": "Stone", "tags": [], "components": [ {"move_resistance":[false]}, {"drip_weakenable":[CellLibrary.ForegroundCells.LOOSE_STONE]}]}
	foreground_dict[ForegroundCells.SMALL_TAPROOT] = {"name": "Small Taproot", "tags": [], "components": ["cookable"]}
	foreground_dict[ForegroundCells.COOKED_SMALL_TAPROOT] = {"name": "Cooked Small Taproot", "tags": [], "components": [{"liquid_dripper": [LiquidType.SAP]}]}
	foreground_dict[ForegroundCells.REED_BULB] = {"name": "Reed Bulb", "tags": [], "components": ["reed_growth"]}
	foreground_dict[ForegroundCells.REED_STEM] = {"name": "Reed Stem", "tags": [], "components": ["flammable"], "can_be_crafted_into":[{"type": ForegroundCells.BUCKET, "autotile": {"x": 0, "y": 3}}]}
	foreground_dict[ForegroundCells.TAPROOT_SHELL] = {"name": "Taproot Shell", "tags": [], "components": ["cookable", {"move_resistance":[false]}, {"nailable": [CellLibrary.ForegroundCells.LOOSE_TAPROOT_SHELL]}]}
	foreground_dict[ForegroundCells.TAPROOT_STEM] = {"name": "Taproot Stem", "tags": [], "components": ["cookable", {"move_resistance":[false]}]}
	foreground_dict[ForegroundCells.BUCKET] = {"name": "Bucket", "tags": [], "components": [{"liquid_container": [3]}]}
	foreground_dict[ForegroundCells.LOOSE_STONE] = {"name": "Loose Stone", "tags": [], "components": []}
	foreground_dict[ForegroundCells.NAIL] = {"name": "Nail", "tags": [], "components": ["hammerable"]}
	foreground_dict[ForegroundCells.ORE] = {"name": "Ore", "tags": [], "components": [ {"move_resistance":[false]}, {"drip_weakenable":[CellLibrary.ForegroundCells.LOOSE_ORE]}]}
	foreground_dict[ForegroundCells.LOOSE_ORE] = {"name": "Loose Ore", "tags": [], "components": [], "can_be_crafted_into":[{"type": ForegroundCells.NAIL, "autotile": {"x": 0, "y": 0}}]}
	foreground_dict[ForegroundCells.LOOSE_TAPROOT_SHELL] = {"name": "Loose Tapproot Shell", "tags": [], "components": []}


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


func get_foreground_tileset():
	return foreground_tileset


func set_sprite_to_tile(sprite, cell_id, autotile_coords):
	var tile_mode = foreground_tileset.tile_get_tile_mode(cell_id)
	sprite.texture = foreground_tileset.tile_get_texture(cell_id)
	if tile_mode == TileSet.SINGLE_TILE:
		sprite.region_rect = foreground_tileset.tile_get_region(cell_id)
		sprite.offset = foreground_tileset.tile_get_texture_offset(cell_id)
	elif tile_mode == TileSet.ATLAS_TILE:
		var region = foreground_tileset.tile_get_region(cell_id)
		sprite.region_rect = Rect2(region.position + autotile_coords*8, Vector2(8, 8))
		sprite.offset = Vector2(0, 0)
