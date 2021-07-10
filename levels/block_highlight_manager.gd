extends Node

onready var Highlight = $Highlight

func _ready() -> void:
	pass


func set_highlight_position(new_position: Vector2):
	Highlight.position = Utilities.grid_pos_to_global_pos(new_position)
