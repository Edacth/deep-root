extends Node
class_name ComponentEventHandler

var FireEffectManager: FireEffectManager


func setup(_FireEffectManager: FireEffectManager):
	FireEffectManager = _FireEffectManager


func handle_event(name, args):
	match name:
		"fire_ignited":
			FireEffectManager.create_fire_effect(args[1])
		"fire_extinguished":
			FireEffectManager.delete_fire_effect(args[1])
