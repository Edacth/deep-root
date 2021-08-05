extends MarginContainer


func _ready() -> void:
	pass


func set_label0_text(object0, object1):
	$VBoxContainer/Label0.text = str(object1)


func set_label1_text(text: String):
	$VBoxContainer/Label1.text = text
