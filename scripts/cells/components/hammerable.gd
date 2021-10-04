extends BaseComponent
class_name Hammerable

var hammered_level = 0
var max_hammered_level = 3
var nailable_whitelist = [CellLibrary.ForegroundCells.GRASS, CellLibrary.ForegroundCells.DIRT, CellLibrary.ForegroundCells.TAPROOT_STEM]

func setup():
	pass


func on_adjacent_cell_move(old_adjacent_cell_position, new_adjacent_cell_position):
	var parent_cell_position = fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "get_parent_cell_position", [])
	var hammerable_position = parent_cell_position + Vector2(-1, 0)
	var hammerable_swing_position = parent_cell_position + Vector2(-2, 0)
	var nailing_position = parent_cell_position + Vector2(1, 0)
#	var hammerable_position_cell = fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "get_cellv", [hammerable_position])
	if new_adjacent_cell_position == hammerable_position && old_adjacent_cell_position == hammerable_swing_position:
		var nailing_position_cell = fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "get_cellv", [nailing_position])
		if nailable_whitelist.has(nailing_position_cell.id) || nailing_position_cell.has_tag("nailable"):
			hammer_in(nailing_position_cell)


func on_move(new_position):
	hammered_level = 0
	fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "set_autotile", [Vector2(0, 0)])


func hammer_in(nailed_cell):
	if hammered_level < max_hammered_level:
		hammered_level += 1
		var parent_autotile = fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "get_autotile", [])
		parent_autotile.y += 1
		fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "set_autotile", [parent_autotile])
		if hammered_level == max_hammered_level && nailed_cell.has_tag("nailable"):
			nailed_cell.get_component("nailable").on_nail_finish()
