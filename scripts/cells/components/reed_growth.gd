extends BaseComponent
class_name ReedGrowth

var growth_cell_type = CellLibrary.ForegroundCells.REED_STEM


func on_random_tick():
	var grown_cell_position = fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "get_parent_cell_position", [])
	grown_cell_position.y -= 1
	var grown_cell = fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "create_cellv", [growth_cell_type])
	fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "set_cellv", [grown_cell_position, grown_cell])
