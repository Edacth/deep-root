extends BaseComponent
class_name Cookable

var above_fire := false
var cook_resistance = 30


func on_moved(new_position):
	var pos_below_me = Vector2(new_position.x, new_position.y+1)
	var cell_below_me: BaseCell = parent_cell.ForegroundManager.get_cellv(pos_below_me)
	if cell_below_me.has_tag("flammable"):
		if cell_below_me.get_component("flammable").is_on_fire():
			above_fire = true
			print("I'm on fire!")
		else:
			above_fire = false
	else:
		above_fire = false


func on_tick():
	if above_fire:
		cook_resistance -= 1
		print(cook_resistance)
	if cook_resistance <= 0:
		parent_cell.ForegroundManager.set_cellv(parent_cell.position, BaseCell.new(CellLibrary.ForegroundCells.COOKED_SMALL_TAPROOT, parent_cell.position, parent_cell.ForegroundManager), true)
