extends Node

onready var Player = $Player
onready var BlockHighlightManager: BlockHighlightManager = $BlockHighlightManager
onready var Foreground := $WorldManager/ForegroundManager

func _ready() -> void:
	# Block Highlight Manager setup
	Player.get_node("BlockSelector").connect("mouse_position_updated", BlockHighlightManager, "set_highlight_position")
	BlockHighlightManager.setup(Foreground)
	
	# Foreground setup
	Player.get_node("BlockSelector").connect("cell_broken", Foreground, "destroy_cell")
	Player.get_node("BlockSelector").connect("cell_moved", Foreground, "move_cell")
	
