extends Resource
class_name BaseCell

signal component_event_fired(name, args)

var id: int
var position: Vector2
var components := Dictionary()


func _init(_id, _position) -> void:
	id = _id
	position = _position
	var component_list = CellLibrary.get_cell_data(id)["components"]
	for component_name in component_list:
#		var hmm = ProjectSettings.get_setting("_global_script_classes")
		var new_component = load("res://scripts/cells/components/" + component_name + ".gd").new()
		new_component.parent_cell = self
		new_component.connect("component_event_fired", self, "echo_component_signal")
		components[component_name] = new_component


func get_name() -> String:
	return CellLibrary.get_cell_data(id)["name"]


func _to_string() -> String:
	return "{} {}".format([id, get_name()], "{}")


func on_tick():
	pass


func on_moved(new_position: Vector2):
	for key in components.keys():
		components[key].on_moved()
	position = new_position


func get_component(component_name: String):
	if components.has(component_name):
		return components[component_name]
	return false


func echo_component_signal(name, args):
	emit_signal("component_event_fired", name, args)
