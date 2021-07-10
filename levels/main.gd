extends Node

onready var Player = $Player
onready var BlockHighlightManager = $BlockHighlightManager
onready var Foreground = $Foreground

func _ready() -> void:
	Player.get_node("BlockSelector").connect("mouse_position_updated", BlockHighlightManager, "set_highlight_position")
	Player.get_node("BlockSelector").connect("block_broken", Foreground, "destroy_block")
