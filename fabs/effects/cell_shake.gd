extends Node2D

var grid_position

func setup(cell_shake_effect_manager, _grid_position, _cell_id, _autotile_coords) -> void:
	grid_position = _grid_position
	CellLibrary.set_sprite_to_tile($Sprite, _cell_id, _autotile_coords)
	$AnimationPlayer.connect("animation_finished", cell_shake_effect_manager, "on_effect_finish", [self])
