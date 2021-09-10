extends Node
class_name DripEffectManager

var drips = []
var SapDripEffect = preload("res://fabs/effects/sap_drip.tscn")
var trigger_drip_contact_on_cell: FuncRef

func setup(_trigger_drip_contact_on_cell) -> void:
	trigger_drip_contact_on_cell = _trigger_drip_contact_on_cell


func create_drip_effect(position: Vector2):
	var new_drip = SapDripEffect.instance()
	new_drip.position = Utilities.grid_pos_to_global_pos(position)
	new_drip.position.x += 5
	new_drip.setup(funcref(self, "on_drip_collide"))
	drips.append(new_drip)
	add_child(new_drip)


func on_drip_collide(collided_drip: Node2D, collision_position):
	collided_drip.queue_free()
	remove_child(collided_drip)
	drips.erase(collided_drip)
	var grid_pos = Utilities.global_pos_to_grid_pos(collision_position)
	trigger_drip_contact_on_cell.call_func(grid_pos, Liquid.LiquidType.SAP)
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test_input"):
		create_drip_effect(Vector2(12, 9))
