extends Control

@export var plot_text = []
@onready var label = $Panel/Prolog
var current_text_index = 0
var end_plot = false

func _ready():
	$Timer.start()
	label.text = plot_text[current_text_index]

func _on_timer_timeout():
	if current_text_index < len(plot_text) - 1:
		current_text_index += 1
		label.text = plot_text[current_text_index]
		$Timer.start()
	else:
		$Timer.stop()
		Main.play_time()
		get_tree().change_scene_to_file("res://Scenes/World/LevelOne.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/World/LevelOne.tscn")
