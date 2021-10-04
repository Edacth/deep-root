extends BaseComponent
class_name AdjacentTest


func on_adjacent_cell_move(old_adjacent_cell_position, new_adjacent_cell_position):
	var parent_cell_position = fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "get_parent_cell_position", [])
	var replacement_cell = fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "create_cellv", [CellLibrary.ForegroundCells.COOKED_SMALL_TAPROOT, parent_cell_position])
	fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "set_cellv", [parent_cell_position, replacement_cell])
