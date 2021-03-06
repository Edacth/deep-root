extends Reference
class_name BaseComponent

enum ComponentEventDestination {
	PARENT_CELL = 0,
	FOREGROUND_MANAGER = 1,
	GLOBAL_EVENT_HANDLER = 2,
}

var fire_component_event: FuncRef
var parent_cell: BaseCell


func on_tick():
	pass


func on_random_tick():
	pass


# warning-ignore:unused_argument
func on_move(new_position):
	pass


func on_adjacent_cell_move(old_adjacent_cell_position, new_adjacent_cell_position):
	pass


func on_liquid_drip_contact(liquid_type):
	pass


func get_provided_tags():
	return []
