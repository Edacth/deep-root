extends Node2D

signal mouse_tile_position_updated(old_position, new_position)
var selected_position := Vector2(0, 0)
var cell_move_input_pressed := false
var moving_cell := false
var position_that_cell_move_was_pressed: Vector2
var timestamp_of_most_recent_move_start
var BlockHighlightManager: BlockHighlightManager
var Foreground: ForegroundManager
var CraftingMenuManager: CraftingMenuManager


func setup(_BlockHighlightManager, _Foreground, _CraftingMenuManager) -> void:
	BlockHighlightManager = _BlockHighlightManager
	Foreground = _Foreground
	CraftingMenuManager = _CraftingMenuManager
	timestamp_of_most_recent_move_start = OS.get_ticks_msec()


func _process(_delta: float) -> void:
	var new_selected_position = get_global_mouse_position()
	new_selected_position = Utilities.global_pos_to_grid_pos(new_selected_position)
	
	if CraftingMenuManager.is_menu_active == false:
		if new_selected_position != selected_position:
			emit_signal("mouse_tile_position_updated", selected_position, new_selected_position)
			selected_position = new_selected_position
		if moving_cell && selected_position != position_that_cell_move_was_pressed && OS.get_ticks_msec() - timestamp_of_most_recent_move_start >= 100:
			
			var position_difference = (new_selected_position - position_that_cell_move_was_pressed)
			var y_difference = Vector2(0, position_difference.y).normalized()
			var x_difference = Vector2(position_difference.x, 0).normalized()
			var difference_to_apply = y_difference
			var success = Foreground.move_cell_with_player_validation(position_that_cell_move_was_pressed, position_that_cell_move_was_pressed+difference_to_apply)
			if !success:
				difference_to_apply = x_difference
				success = Foreground.move_cell_with_player_validation(position_that_cell_move_was_pressed, position_that_cell_move_was_pressed+difference_to_apply)
			if success:
				position_that_cell_move_was_pressed = position_that_cell_move_was_pressed+difference_to_apply
			else:
	#			BlockHighlightManager.set_move_origin_highlight_position(position_that_cell_move_was_pressed)
	#			BlockHighlightManager.set_move_origin_highlight_visibility(true)
				pass
			timestamp_of_most_recent_move_start = OS.get_ticks_msec()
		BlockHighlightManager.set_highlight_position(selected_position)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("light_fire"):
		Foreground.ignite_cell(selected_position)
	elif event.is_action_pressed("move_cell"):
		if CraftingMenuManager.is_menu_active == true: 
			return
		cell_move_input_pressed = true
		position_that_cell_move_was_pressed = selected_position
		if Foreground.get_cellv(selected_position).id != CellLibrary.ForegroundCells.EMPTY:
			moving_cell = true
#			BlockHighlightManager.set_move_origin_highlight_position(position_that_cell_move_was_pressed)
#			BlockHighlightManager.set_move_origin_highlight_visibility(true)
	elif event.is_action_released("move_cell"):
		cell_move_input_pressed = false
		moving_cell = false
		BlockHighlightManager.set_move_origin_highlight_visibility(false)
	elif event.is_action_pressed("open_crafting_menu"):
		CraftingMenuManager.show_crafting_menu(selected_position)
