extends Node2D

var selected_position := Vector2(0, 0)
var cell_move_input_pressed := false
var moving_cell := false
var position_that_cell_move_was_pressed: Vector2
var BlockHighlightManager: BlockHighlightManager
var Foreground: ForegroundManager

#signal mouse_tile_position_updated(old_position, new_position)


func setup(_BlockHighlightManager: BlockHighlightManager, _Foreground: ForegroundManager) -> void:
	BlockHighlightManager = _BlockHighlightManager
	Foreground = _Foreground


func _process(_delta: float) -> void:
	var new_selected_position = get_global_mouse_position()
	new_selected_position = Utilities.global_pos_to_grid_pos(new_selected_position)
	
	if new_selected_position != selected_position:
		selected_position = new_selected_position
		if moving_cell:
			var success = Foreground.move_cell_with_player_validation(position_that_cell_move_was_pressed, new_selected_position)
			if success:
				position_that_cell_move_was_pressed = new_selected_position
				BlockHighlightManager.set_move_origin_highlight_position(position_that_cell_move_was_pressed)
		BlockHighlightManager.set_highlight_position(selected_position)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("break_cell") && event:
		emit_signal("cell_broken", selected_position)
	elif event.is_action_pressed("move_cell"):
		cell_move_input_pressed = true
		position_that_cell_move_was_pressed = selected_position
		if Foreground.get_cellv(selected_position).id != CellLibrary.ForegroundCells.EMPTY:
			moving_cell = true
			BlockHighlightManager.set_move_origin_highlight_position(position_that_cell_move_was_pressed)
			BlockHighlightManager.set_move_origin_highlight_visibility(true)
	elif event.is_action_released("move_cell"):
		cell_move_input_pressed = false
		moving_cell = false
		BlockHighlightManager.set_move_origin_highlight_visibility(false)
