extends Control




func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Prolog.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Settings.tscn")


func _on_quit_pressed():
	get_tree().quit()
