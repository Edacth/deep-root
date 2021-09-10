extends KinematicBody2D

var velocity = Vector2(0, 50.0)
var on_drip_collide: FuncRef


func setup(_on_drip_collide):
	on_drip_collide = _on_drip_collide


func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		on_drip_collide.call_func(self, collision_info.position)
