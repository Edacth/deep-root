extends BaseComponent
class_name Flammable

var on_fire := false


func set_fire(_on_fire):
	on_fire = _on_fire
	emit_signal("component_event_fired", "fire_ignited", [self, parent_cell.position])


func on_moved():
	if on_fire:
		on_fire = false
		emit_signal("component_event_fired", "fire_extinguished", [self, parent_cell.position])
