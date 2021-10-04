extends Node2D
class_name crafting_menu

signal option_selected
signal mouse_exited
var source_cell : BaseCell
var grid_position: Vector2
var SectionContainer: HBoxContainer
var SourceCellSprite: Sprite
var craft_option_nodes = []
var CraftOptionFab = preload("res://fabs/crafting_menu/craft_option.tscn")


func setup() -> void:
	SectionContainer = $MainContainer/Shrinker/SectionContainer
	SourceCellSprite = $MainContainer/Shrinker/SectionContainer/MainSection/SourceCellSprite
	$MainContainer.connect("mouse_exited", self, "on_mouse_exited")


func set_data(_source_cell, _grid_position):
	source_cell = _source_cell
	grid_position = _grid_position
	CellLibrary.set_sprite_to_tile(SourceCellSprite, source_cell.id, source_cell.get_autotile())
	var craft_options = []
	if CellLibrary.foreground_dict[source_cell.id].has("can_be_crafted_into"):
		craft_options = CellLibrary.foreground_dict[source_cell.id]["can_be_crafted_into"]
	while craft_option_nodes.size() < craft_options.size():
		var new_option = CraftOptionFab.instance()
		new_option.setup(funcref(self, "on_option_selected"))
		craft_option_nodes.append(new_option)
		SectionContainer.add_child(new_option)
	for i in range(craft_option_nodes.size()):
		if i < craft_options.size():
			craft_option_nodes[i].set_cell_id(craft_options[i]["type"], craft_options[i]["autotile"])
			if !is_instance_valid(craft_option_nodes[i].get_parent()):
				SectionContainer.add_child(craft_option_nodes[i])
		else:
			if is_instance_valid(craft_option_nodes[i].get_parent()):
				SectionContainer.remove_child(craft_option_nodes[i])


func on_option_selected(cell_id, autotile):
	emit_signal("option_selected", cell_id, autotile, grid_position)


func _on_MainContainer_mouse_exited() -> void:
	emit_signal("mouse_exited")


func _on_Shrinker_mouse_exited() -> void:
	emit_signal("mouse_exited")


func _on_SectionContainer_mouse_exited() -> void:
	var mouse_is_inside = SectionContainer.get_global_rect().has_point(SectionContainer.get_global_mouse_position())
	if !mouse_is_inside:
		emit_signal("mouse_exited")
