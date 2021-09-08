extends Node
class_name ForegroundManager

var elevate_component_event: FuncRef

var cells: Array2D
var chunk_size := 8
var map_size_in_chunks
var CellMovementLerper: CellMovementLerper
var FireEffectManager: FireEffectManager
var CellShakeEffectManager: CellShakeEffectManager
var timestamp_of_most_recent_tick
onready var ForeTilemap = $Foreground
var ComponentEventDestination = load("res://scripts/cells/components/base_component.gd").ComponentEventDestination


func setup(_CellMovementLerper, _FireEffectManager, _CellShakeEffectManager) -> void:
	CellMovementLerper = _CellMovementLerper
	FireEffectManager = _FireEffectManager
	CellShakeEffectManager = _CellShakeEffectManager
	read_tilemap_state()
	timestamp_of_most_recent_tick = OS.get_ticks_msec()


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
			rows.append(create_cellv(CellLibrary.ForegroundCells.EMPTY, Vector2(_i, _j)))
		cells.append_row(rows)
	for cell_pos in initial_cells:
		var autotile_coords = ForeTilemap.get_cell_autotile_coord(cell_pos.x, cell_pos.y)
		var new_cell = create_cellv(ForeTilemap.get_cellv(cell_pos), cell_pos, autotile_coords)
		cells.set_cellv(cell_pos, new_cell)
	
	var foreground_size = cells.vector_size()
	map_size_in_chunks = Vector2.ZERO
	map_size_in_chunks.x = ceil(foreground_size.x / 8)
	map_size_in_chunks.y = ceil(foreground_size.y / 8)


func get_cellv(position: Vector2) -> BaseCell:
	if !cells.has_cellv(position):
		return null
	var cell = cells.get_cellv(position)
#	print(cell)
	return cell


func are_tiles_adjacent(position1: Vector2, position2: Vector2) -> bool:
	var distance = sqrt(pow(position2.x - position1.x, 2) + pow(position2.y - position1.y, 2))
	if distance <= 1:
		return true
	return false


func create_cellv(cell_type, cell_position = Vector2(0, 0), autotile = Vector2(0, 0)) -> BaseCell:
	var new_cell = BaseCell.new(cell_type, cell_position, self, funcref(self, "process_component_event"), autotile)
	return new_cell


func set_cellv(set_position: Vector2, value: BaseCell, update_visually: bool = true):
	var result = cells.set_cellv_if_exists(set_position, value)
	if result:
		value.position = set_position
		if update_visually:
			ForeTilemap.set_cell(set_position.x, set_position.y, value.id, false, false, false, value.autotile)
			ForeTilemap.update_dirty_quadrants()


func replace_cellv(replace_position: Vector2, value: BaseCell, update_visually: bool = true):
	pass


func destroy_cell(destroy_position: Vector2):
	set_cellv(destroy_position, create_cellv(CellLibrary.ForegroundCells.EMPTY, destroy_position))
	

func move_cell_with_player_validation(from_position: Vector2, to_position: Vector2) -> bool:
	if are_tiles_adjacent(from_position, to_position) == false:
		return false
	if get_cellv(to_position).id != CellLibrary.ForegroundCells.EMPTY:
		return false
	var result = move_cell(from_position, to_position, true)
	if !result: return false
	var moved_cell = get_cellv(to_position)
	CellMovementLerper.create_lerp_effect(from_position, to_position, moved_cell.id, moved_cell.autotile)
	return true


func move_cell(from_position: Vector2, to_position: Vector2, play_lerp: bool = false) -> bool:
	var from_value = get_cellv(from_position)
	var move_resistance_component = from_value.get_component("move_resistance")
	if typeof(move_resistance_component) != TYPE_BOOL:
		if move_resistance_component.is_moveable() == false:
			CellShakeEffectManager.create_new_effect(from_position, from_value.id, from_value.autotile)
			return false
	from_value.on_moved(to_position)
	set_cellv(to_position, from_value, !play_lerp)
	set_cellv(from_position, create_cellv(CellLibrary.ForegroundCells.EMPTY, from_position))
	return true


func ignite_cell(position: Vector2) -> bool:
	var chosen_cell = get_cellv(position)
	var flammable_component = chosen_cell.get_component("flammable")
	if typeof(flammable_component) != TYPE_BOOL:
		flammable_component.set_fire(true)
		return true
	return false


func update_cell_visually(position: Vector2):
	var data := get_cellv(position)
	ForeTilemap.set_cell(position.x, position.y, data.id, false, false, false, data.autotile)


func process_component_event(destination, name, args):
	if destination == ComponentEventDestination.FOREGROUND_MANAGER:
		match name:
#			"get_cellv":
#				return callv("get_cellv", args)
			_:
				if has_method(name):
					return callv(name, args)
	else:
		return elevate_component_event.call_func(destination, name, args)


func choose_random_tick_locations(number_of_ticks, corner1, corner2):
	var locations = []
	for _i in range(number_of_ticks):
		var location = Vector2(
			(randi() % int(corner2.x+1))+int(corner1.x),
			(randi() % int(corner2.y+1))+int(corner1.y)
		)
		locations.append(location)
	return locations


func _physics_process(_delta: float) -> void:
	# Map Ticks
	if OS.get_ticks_msec() - timestamp_of_most_recent_tick >= 100:
		timestamp_of_most_recent_tick = OS.get_ticks_msec()
		var rows = cells.get_rows()
		for i in range(rows.size()):
			for j in range(rows[i].size()):
				rows[i][j].on_tick()
		
		# Random Ticks
		for i in range(map_size_in_chunks.x):
			for j in range(map_size_in_chunks.y):
				var corner1 = Vector2(i * 8, j * 8)
				var corner2 = Vector2(((i+1) * 8)-1, ((j+1) * 8)-1)
				var random_tick_locations = choose_random_tick_locations(1, corner1, corner2)
				for location in random_tick_locations:	
					if cells.has_cellv(location):
						cells.data[location.x][location.y].on_random_tick()
	
