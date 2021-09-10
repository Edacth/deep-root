extends BaseComponent
class_name LiquidDripper

var LiquidType = load("res://scripts/liquid.gd").LiquidType
var liquid_type
var liquid_remaining = 10
var drip_interval = 10
var ticks_until_drip

func setup(_liquid_type):
	liquid_type = _liquid_type
	ticks_until_drip = drip_interval


func on_tick():
	ticks_until_drip -= 1
	if ticks_until_drip == 0:
		drip()
		ticks_until_drip = drip_interval


func drip():
	var drip_position = parent_cell.position
	drip_position.y += 1
	fire_component_event.call_func(ComponentEventDestination.GLOBAL_EVENT_HANDLER, "create_drip", [self, drip_position])
