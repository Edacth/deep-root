extends Node
class_name ForegroundManager

var cells: Array2D
onready var ForeTilemap = $Foreground


func _ready() -> void:
	read_tilemap_state()


func read_tilemap_state():
	cells = Array2D.new([], false)
	var largest_position = Vector2(0,0)
	var initial_cells = ForeTilemap.get_used_cells()
	# Find largest position
	for cell_pos in initial_cells:
		if cell_pos.x > largest_position.x:
			largest_position.x = cell_pos.x
		if cell_pos.y > largest_position.y:
			largest_position.y = cell_pos.y
	# Construct Array2D
	for _i in range(largest_position.x+1):
		var rows = []
		for _j in range(largest_position.y+1):
			rows.append(BaseCell.new(-1))
		cells.append_row(rows)
	for cell_pos in initial_cells:
		var new_cell = BaseCell.new(ForeTilemap.get_cellv(cell_pos))
		cells.set_cellv(cell_pos, new_cell)


func get_cellv(position: Vector2) -> BaseCell:
	if !cells.has_cellv(position):
		return null
	var cell = cells.get_cellv(position)
	print(cell)
	return cell


func are_tiles_adjacent(position1: Vector2, position2: Vector2) -> bool:
	var distance = sqrt(pow(position2.x - position1.x, 2) + pow(position2.y - position1.y, 2))
	if distance <= 1:
		return true
	return false


func set_cellv(set_position: Vector2, value: BaseCell):
	var result = cells.set_cellv_if_exists(set_position, value)
	if result:
		ForeTilemap.set_cellv(set_position, value.id)
		ForeTilemap.update_dirty_quadrants()


func destroy_cell(destroy_position: Vector2):
	set_cellv(destroy_position, BaseCell.new(CellLibrary.ForegroundCells.EMPTY))
#	var cell = ForeTilemap.get_cellv(destroy_position)
#	if CellLibrary.has_tag(cell, "breakable"):
#		ForeTilemap.set_cellv(destroy_position, 0, false, false, false)
#		ForeTilemap.update_dirty_quadrants()
	

func move_cell_with_player_validation(from_position: Vector2, to_position: Vector2) -> bool:
	if are_tiles_adjacent(from_position, to_position) == false:
		return false
	if get_cellv(to_position).id != CellLibrary.ForegroundCells.EMPTY:
		return false
	move_cell(from_position, to_position)
	return true


func move_cell(from_position: Vector2, to_position: Vector2):
	var from_value = get_cellv(from_position)
	set_cellv(to_position, from_value)
	set_cellv(from_position, BaseCell.new(CellLibrary.ForegroundCells.EMPTY))
