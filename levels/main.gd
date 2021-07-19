extends Node

onready var Player = $Player
onready var BlockHighlightManager: BlockHighlightManager = $BlockHighlightManager
onready var Foreground := $WorldManager/ForegroundManager
onready var GUI = $CanvasLayer/GUI


func _ready() -> void:
	# Block Highlight Manager setup
	BlockHighlightManager.setup(Foreground)
	
	# Foreground setup
	
	# GUI setup
#	Player.get_node("BlockSelector").connect("cell_move_input_changed", GUI, "set_label0_text")
	
	# Player setup
	Player.get_node("BlockSelector").setup(BlockHighlightManager, Foreground)
