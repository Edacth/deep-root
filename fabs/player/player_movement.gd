extends KinematicBody2D

onready var input_axis := Vector2(0, 0)
onready var horizontal_acceleration := 50.0
onready var gravity := 70.0
onready var max_speed := 30.0
var velocity: Vector2

signal velocity_changed


func _physics_process(_delta: float) -> void:
	# Horizontal
	input_axis = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 0)
	velocity = input_axis * horizontal_acceleration
	# Vertical
	velocity.y = gravity
	var _idk = move_and_slide(velocity, Vector2.UP, false, 4, deg2rad(45), false)
	emit_signal("velocity_changed", "%.2f, %.2f" % [velocity.x, velocity.y] )
#	velocity -= velocity * 2.0 * delta
