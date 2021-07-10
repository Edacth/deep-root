extends TileMap


func _ready() -> void:
	pass


func destroy_block(destroy_position: Vector2):
	set_cellv(destroy_position, 0, false, false, false)
	update_dirty_quadrants()
