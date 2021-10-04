extends BaseComponent
class_name DripWeakenable

var weakened_transformation_cell_type = CellLibrary.ForegroundCells.LOOSE_STONE
var moveable_stone_autotile = Vector2()

func setup(_weakened_transformation_cell_type):
	weakened_transformation_cell_type = _weakened_transformation_cell_type
	

func on_liquid_drip_contact(liquid_type):
	if liquid_type == Liquid.LiquidType.SAP:
#		var move_resistance_component = fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "get_component", ["move_resistance"])
#		move_resistance_component.set_moveable(true)
		var parent_position = fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "get_parent_cell_position", [])
		var weakened_transformation_cell = fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "create_cellv", [weakened_transformation_cell_type, parent_position])
		fire_component_event.call_func(ComponentEventDestination.FOREGROUND_MANAGER, "set_cellv", [parent_position, weakened_transformation_cell])
