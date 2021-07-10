extends Node2D

var selected_position := Vector2(0, 0)

signal mouse_position_updated(position)
signal block_broken(position)

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var new_selected_position = get_global_mouse_position()
	new_selected_position = Utilities.global_pos_to_grid_pos(new_selected_position)
	
	if new_selected_position != selected_position:
		emit_signal("mouse_position_updated", new_selected_position)
		selected_position = new_selected_position


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("break_block"):
		emit_signal("block_broken", selected_position)
