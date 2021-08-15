extends BaseComponent
class_name Flammable

var on_fire := false


func is_on_fire() -> bool:
	return on_fire


func set_fire(_on_fire):
	on_fire = _on_fire
	emit_signal("component_event_fired", "fire_ignited", [self, parent_cell.position])


func on_moved(new_position):
	if on_fire:
		on_fire = false
		emit_signal("component_event_fired", "fire_extinguished", [self, parent_cell.position])


func get_provided_tags():
	return ["flammable"]
