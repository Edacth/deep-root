extends Node
class_name CellMovementLerper

onready var Sprite = $Sprite
onready var Tween = $Tween

signal lerp_effect_finished(to_position)


func setup() -> void:
	Tween.connect("tween_completed", self, "emit_lerp_effect_finished")
	Sprite.visible = false


func create_lerp_effect(from_position: Vector2, to_position: Vector2):
	from_position = Utilities.grid_pos_to_global_pos(from_position)
	to_position = Utilities.grid_pos_to_global_pos(to_position)
	Sprite.visible = true
	Tween.interpolate_property(Sprite, "position", from_position, to_position, 0.1, Tween.TRANS_LINEAR)
	Tween.start()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test_input"):
		create_lerp_effect(Vector2(12, 12), Vector2(11, 12))


func emit_lerp_effect_finished(object, key):
	emit_signal("lerp_effect_finished", Utilities.global_pos_to_grid_pos(object.position))
	Sprite.visible = false
