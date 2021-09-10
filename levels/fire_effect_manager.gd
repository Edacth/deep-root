extends Node
class_name FireEffectManager

var fires = []
onready var FireEffect = preload("res://fabs/effects/fire.tscn")


func create_fire_effect(position: Vector2):
	var new_fire = FireEffect.instance()
	new_fire.position = Utilities.grid_pos_to_global_pos(position)
	fires.append(new_fire)
	add_child(new_fire)
	

func delete_fire_effect(position: Vector2):
	for fire in fires:
		if fire.position == Utilities.grid_pos_to_global_pos(position):
			fire.queue_free()
			fires.erase(fire)
