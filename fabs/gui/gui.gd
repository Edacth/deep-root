extends MarginContainer


func _ready() -> void:
	pass


func set_label0_text(object):
	$VBoxContainer/Label0.text = str(object)


func set_label1_text(text: String):
	$VBoxContainer/Label1.text = text
