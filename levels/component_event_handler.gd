extends Node
class_name ComponentEventHandler

var FireEffectManager: FireEffectManager
var DripEffectManager: DripEffectManager


func setup(_FireEffectManager, _DripEffectManager):
	FireEffectManager = _FireEffectManager
	DripEffectManager = _DripEffectManager


func process_component_event(destination, name, args):
	match name:
		"ignite_fire":
			FireEffectManager.create_fire_effect(args[1])
		"extinguish_fire":
			FireEffectManager.delete_fire_effect(args[1])
		"create_drip":
			DripEffectManager.create_drip_effect(args[1])
