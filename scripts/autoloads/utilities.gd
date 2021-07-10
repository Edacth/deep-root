extends Node

var current_scene = null
var Foreground: TileMap = null

func _ready() -> void:
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	Foreground = current_scene.get_node("Foreground")


func global_pos_to_grid_pos(global_pos: Vector2) -> Vector2:
	var local_pos = Foreground.to_local(global_pos)
	return Foreground.world_to_map(local_pos)
#	return Vector2(floor(global_pos.x / 8) * 8, floor(global_pos.y / 8) * 8)


func grid_pos_to_global_pos(grid_pos: Vector2) -> Vector2:
	var local_pos = Foreground.map_to_world(grid_pos)
	return Foreground.to_global(local_pos)


