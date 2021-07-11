extends Node2D

var selected_position := Vector2(0, 0)

signal mouse_position_updated(position)
signal cell_broken(position)
signal cell_moved(from_position, to_position)

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	var new_selected_position = get_global_mouse_position()
	new_selected_position = Utilities.global_pos_to_grid_pos(new_selected_position)
	
	if new_selected_position != selected_position:
		emit_signal("mouse_position_updated", new_selected_position)
		selected_position = new_selected_position


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("break_cell") && event:
		emit_signal("cell_broken", selected_position)
	elif event.is_action_pressed("move_cell"):
		var to_position = Vector2(selected_position.x, selected_position.y-1)
		emit_signal("cell_moved", selected_position, to_position)
		
