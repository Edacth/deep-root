extends Node
class_name CellMovementLerper

onready var Sprite = $Sprite
onready var Tween = $Tween
var inactive_position = Vector2(-64, -64)

signal lerp_effect_finished(to_position)


func setup() -> void:
	Tween.connect("tween_completed", self, "emit_lerp_effect_finished")
	Sprite.position = inactive_position
#	Sprite.visible = false


func create_lerp_effect(from_position: Vector2, to_position: Vector2, cell_id: int):
	from_position = Utilities.grid_pos_to_global_pos(from_position)
	to_position = Utilities.grid_pos_to_global_pos(to_position)
	var texture_region = CellLibrary.get_cell_uv_rect(cell_id)
	var texture_offset = CellLibrary.get_cell_texture_offset(cell_id)
	Sprite.region_rect = texture_region
	Sprite.offset = texture_offset
#	Sprite.visible = true
	Sprite.position = from_position
	Tween.interpolate_property(Sprite, "position", from_position, to_position, 0.1, Tween.TRANS_LINEAR)
	Tween.start()
#	print("Start lerp effect")


func emit_lerp_effect_finished(object, key):
	emit_signal("lerp_effect_finished", Utilities.global_pos_to_grid_pos(object.position))
	Sprite.position = inactive_position
#	print("End lerp effect")
#	Sprite.visible = false
