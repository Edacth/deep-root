extends BaseComponent
class_name Flammable

var on_fire := false


func is_on_fire() -> bool:
	return on_fire


func set_fire(_on_fire):
	on_fire = _on_fire
	fire_component_event.call_func(ComponentEventDestination.GLOBAL_EVENT_HANDLER, "ignite_fire", [self, parent_cell.position])


func on_moved(new_position):
	if on_fire:
		on_fire = false
		fire_component_event.call_func(ComponentEventDestination.GLOBAL_EVENT_HANDLER, "extinguish_fire", [self, parent_cell.position])


func get_provided_tags():
	return ["flammable"]
