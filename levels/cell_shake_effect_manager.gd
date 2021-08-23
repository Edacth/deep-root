extends Node
class_name CellShakeEffectManager

var effects = []
var CellShakeEffect = preload("res://fabs/effects/cell_shake.tscn")

func create_new_effect(position: Vector2, cell_id: int, autotile_coords = Vector2(0, 0)) -> bool:
	for	effect in effects:
		if position == effect.grid_position:
			return false
	var new_shake = CellShakeEffect.instance()
	new_shake.position = Utilities.grid_pos_to_global_pos(position)
	effects.append(new_shake) 
	new_shake.setup(self, position, cell_id, autotile_coords)
	add_child(new_shake)
	new_shake.get_node("AnimationPlayer").play("cell_shake")
	return true



func on_effect_finish(animation_name, finished_effect: Node2D):
	finished_effect.queue_free()
	remove_child(finished_effect)
	effects.erase(finished_effect)


#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("test_input"):
#		create_new_effect(Vector2(12, 12))
