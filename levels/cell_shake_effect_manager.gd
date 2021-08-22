extends Node
class_name CellShakeEffectManager

var effects = []
var CellShakeEffect = preload("res://fabs/effects/cell_shake.tscn")

func create_new_shake_effect(position: Vector2):
	var new_shake = CellShakeEffect.instance()
	new_shake.position = Utilities.grid_pos_to_global_pos(position)
	effects.append(new_shake)
	add_child(new_shake)
	new_shake.get_node("AnimationPlayer").play("cell_shake")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test_input"):
		create_new_shake_effect(Vector2(12, 12))
