extends Node
class_name CraftingMenuManager

const CraftingMenuScene = preload("res://fabs/crafting_menu/crafting_menu.tscn")
var CraftingMenu: Node
var ForegroundManager: ForegroundManager
var is_menu_active: bool setget ,get_is_menu_active


func setup(_ForegroundManager) -> void:
	ForegroundManager = _ForegroundManager
	CraftingMenu = CraftingMenuScene.instance()
	CraftingMenu.setup()
	CraftingMenu.connect("option_selected", self, "on_option_selected")
	CraftingMenu.connect("mouse_exited", self, "hide_crafting_menu")


func get_is_menu_active():
	return is_menu_active


func show_crafting_menu(grid_position):
	var cell = ForegroundManager.get_cellv(grid_position)
	var global_position = Utilities.grid_pos_to_global_pos(grid_position)
	global_position.x -= 1
	global_position.y -= 1
	CraftingMenu.position = global_position
	CraftingMenu.set_data(cell, grid_position)
	if !is_instance_valid(CraftingMenu.get_parent()):
		add_child(CraftingMenu)
	is_menu_active = true


func hide_crafting_menu():
	remove_child(CraftingMenu)
	is_menu_active = false


func on_option_selected(cell_id, autotile, grid_position):
	var new_cell = ForegroundManager.create_cellv(cell_id, grid_position, Vector2(autotile.x, autotile.y))
	ForegroundManager.set_cellv(grid_position, new_cell)
	hide_crafting_menu()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test_input"):
		show_crafting_menu(Vector2(14, 14))
