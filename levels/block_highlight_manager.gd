extends Node
class_name BlockHighlightManager

onready var Highlight = $Highlight
var Foreground: ForegroundManager

func setup(_Foreground: ForegroundManager):
	self.Foreground = _Foreground


func set_highlight_position(new_position: Vector2):
	if Foreground.get_cellv(new_position).id != CellLibrary.ForegroundCells.EMPTY:
		Highlight.position = Utilities.grid_pos_to_global_pos(new_position)
		_set_highlight_visibility(true)
	else:
		_set_highlight_visibility(false)


func _set_highlight_visibility(visible: bool):
	Highlight.visible = visible
