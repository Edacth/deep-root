extends Reference
class_name BaseComponent

enum ComponentEventDestination {
	PARENT_CELL = 0,
	FOREGROUND_MANAGER = 1,
	GLOBAL_EVENT_HANDLER = 2,
}

#signal component_event_fired(name, args)
var fire_component_event: FuncRef
var parent_cell: BaseCell


#func _init(_fire_component_event) -> void:
#	fire_component_event = _fire_component_event


func on_tick():
	pass


func on_moved(new_position):
	pass


func get_provided_tags():
	return []
