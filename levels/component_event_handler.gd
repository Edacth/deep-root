extends Node
class_name ComponentEventHandler

var FireEffectManager: FireEffectManager


func setup(_FireEffectManager: FireEffectManager):
	FireEffectManager = _FireEffectManager


func process_component_event(destination, name, args):
	match name:
		"ignite_fire":
			FireEffectManager.create_fire_effect(args[1])
		"extinguish_fire":
			FireEffectManager.delete_fire_effect(args[1])
