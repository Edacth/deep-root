extends Node

onready var Player = $Player
onready var BlockHighlightManager: BlockHighlightManager = $BlockHighlightManager
onready var Foreground := $WorldManager/ForegroundManager
onready var GUI = $CanvasLayer/GUI
onready var CellMovementLerper = $CellMovementLerper


func _ready() -> void:
	# Block Highlight Manager setup
	BlockHighlightManager.setup(Foreground)
	
	# Foreground setup
	Foreground.setup(CellMovementLerper)
	CellMovementLerper.connect("lerp_effect_finished", Foreground, "update_cell_visually")
	
	# GUI setup
	Player.get_node("BlockSelector").connect("mouse_tile_position_updated", GUI, "set_label0_text")
	
	# Player setup
	Player.get_node("BlockSelector").setup(BlockHighlightManager, Foreground)
	
	# CellMovementLerper setup
	CellMovementLerper.setup()
