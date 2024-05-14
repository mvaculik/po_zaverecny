extends Control

@export var dialog_text = []
@onready var label = $Panel/Label
var current_text_index = 0

func _ready():
	label.text = dialog_text[current_text_index]

func _on_next_pressed():
	if current_text_index < len(dialog_text) - 1:
			current_text_index += 1
			label.text = dialog_text[current_text_index]
	else:
		current_text_index = -1
		Main.update_dialog("end")
