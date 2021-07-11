extends Resource
class_name BaseCell

var id: int


func _init(_id) -> void:
	id = _id


func get_name() -> String:
	return CellLibrary.get_cell_data(id)["name"]


func _to_string() -> String:
	return "{} {}".format([id, get_name()], "{}")
