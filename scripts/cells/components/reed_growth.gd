extends BaseComponent
class_name ReedGrowth

var growth_cell_type = CellLibrary.ForegroundCells.REED_STEM


func on_random_tick():
	var parent_position = fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "get_parent_cell_position", [])
	for i in range(1, 3):
		var cell_place_position = Vector2(parent_position.x, parent_position.y-i)
		var cell_in_place_position = fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "get_cellv", [cell_place_position])
		if cell_in_place_position.id == CellLibrary.ForegroundCells.EMPTY:
			# Grow
			var grown_cell = fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "create_cellv", [growth_cell_type])
			fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "set_cellv", [cell_place_position, grown_cell])
			return
		elif cell_in_place_position.id == CellLibrary.ForegroundCells.REED_STEM:
			# Continue past the first stem
			continue
		else:
			# Is blocked
			return
