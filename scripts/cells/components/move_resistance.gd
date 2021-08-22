extends BaseComponent
class_name MoveResistance

var moveable := true


func setup(_moveable):
	moveable = _moveable


func set_moveable(_moveable):
	moveable = _moveable


func is_moveable():
	return moveable
