extends BaseComponent
class_name LiquidContainer

var LiquidType = load("res://scripts/liquid.gd").LiquidType
var max_fill_level
var fill_level
var liquid_type

func setup(_max_fill_level):
	max_fill_level = _max_fill_level
	fill_level = 0


func on_liquid_drip_contact(liquid_type):
	if fill_level < max_fill_level:
		fill_level += 1
		var parent_autotile = fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "get_autotile", [])
		parent_autotile.y -= 1
		fire_component_event.call_func(ComponentEventDestination.PARENT_CELL, "set_autotile", [parent_autotile])
