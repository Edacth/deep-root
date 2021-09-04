extends Resource
class_name BaseCell

var id: int
var position: Vector2
var ForegroundManager
var components := Dictionary()
var autotile: Vector2
var elevate_component_event: FuncRef
var ComponentEventDestination = load("res://scripts/cells/components/base_component.gd").ComponentEventDestination


func _init(_id, _position, _ForegroundManager, _elevate_component_event, _autotile = Vector2(0, 0)) -> void:
	id = _id
	position = _position
	ForegroundManager = _ForegroundManager
	elevate_component_event = _elevate_component_event
	autotile = _autotile
	var component_list = CellLibrary.get_cell_data(id)["components"]
	for component in component_list:
		var component_name
		var component_params = []
		if typeof(component) != TYPE_STRING:
			component_name = component.keys()[0]
			component_params = component[component.keys()[0]]
		else:
			component_name = component
#		var hmm = ProjectSettings.get_setting("_global_script_classes")
		var new_component = load("res://scripts/cells/components/" + component_name + ".gd").new()
		if component_params.size() > 0:
			new_component.callv("setup", component_params)
		new_component.fire_component_event = funcref(self, "process_component_signal")
		new_component.parent_cell = self
		components[component_name] = new_component


func get_name() -> String:
	return CellLibrary.get_cell_data(id)["name"]


func get_tags_of_components():
	var tags = []
	for key in components:
		tags += components[key].get_provided_tags()
	return tags


func has_tag(searched_tag: String) -> bool:
	if CellLibrary.has_tag(id, searched_tag):
		return true
	elif searched_tag in get_tags_of_components():
		return true
	else:
		return false


func _to_string() -> String:
	return "{} {}".format([id, get_name()], "{}")


func on_tick():
	for key in components:
		components[key].on_tick()


func on_random_tick():
	for key in components:
		components[key].on_random_tick()


func on_moved(new_position: Vector2):
	for key in components:
		components[key].on_moved(new_position)
	position = new_position


func get_component(component_name: String):
	if components.has(component_name):
		return components[component_name]
	return false


func process_component_signal(destination, name, args):
	if destination == ComponentEventDestination.PARENT_CELL:
		match name:
			"get_parent_cell_position":
				return position
			_:
				if has_method(name):
					return callv(name, args)
	else:
		return elevate_component_event.call_func(destination, name, args)
