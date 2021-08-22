extends Node

onready var Player = $Player
onready var BlockHighlightManager: BlockHighlightManager = $BlockHighlightManager
onready var Foreground := $WorldManager/ForegroundManager
onready var FireEffectManager := $FireEffectManager
onready var GUI = $CanvasLayer/GUI
onready var CellMovementLerper = $CellMovementLerper
onready var ComponentEventHandler = $ComponentEventHandler


func _ready() -> void:
	# Block Highlight Manager setup
	BlockHighlightManager.setup(Foreground)
	
	# Foreground setup
	Foreground.setup(CellMovementLerper, FireEffectManager)
	Foreground.elevate_component_event = funcref(ComponentEventHandler, "process_component_event")
	CellMovementLerper.connect("lerp_effect_finished", Foreground, "update_cell_visually")
	
	# GUI setup
	Player.get_node("BlockSelector").connect("mouse_tile_position_updated", GUI, "set_label0_text")
	
	# Player setup
	Player.get_node("BlockSelector").setup(BlockHighlightManager, Foreground)
	
	# CellMovementLerper setup
	CellMovementLerper.setup()
	
	# ComponentEventHandler setup
	ComponentEventHandler.setup(FireEffectManager)
#	Foreground.connect("component_event_fired", ComponentEventHandler, "handle_event")
