extends PanelContainer

var option_selected_func: FuncRef
var cell_id
var autotile

func setup(_option_selected_func) -> void:
	option_selected_func = _option_selected_func


func set_cell_id(_cell_id, _autotile):
	cell_id = _cell_id
	autotile = _autotile
	CellLibrary.set_sprite_to_tile($Sprite, cell_id, Vector2(autotile.x, autotile.y))


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			option_selected_func.call_func(cell_id, autotile)
