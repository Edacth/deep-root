extends Reference
class_name BaseComponent

signal component_event_fired(name, args)

var parent_cell: BaseCell


func on_tick():
	pass


func on_moved(new_position):
	pass


func get_provided_tags():
	return []
