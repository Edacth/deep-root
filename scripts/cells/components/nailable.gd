extends BaseComponent
class_name Nailable

var nailed_transformation_cell_type

func setup(_nailed_transformation_cell_type):
	nailed_transformation_cell_type = _nailed_transformation_cell_type
	

func on_nail_finish():
	var parent_cell_position = fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "get_parent_cell_position", [])
	var parent_autotile = fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "get_autotile", [])
	var replacement_cell = fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "create_cellv", [nailed_transformation_cell_type, parent_cell_position, parent_autotile])
	fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "set_cellv", [parent_cell_position, replacement_cell])


func get_provided_tags():
	return ["nailable"]
