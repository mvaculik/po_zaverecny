extends Control

var time_win = 0
var level = 0

func _ready():
	Main.level.connect(_update_level)

func _process(_delta):
	time_win = Main.end_time
	$Control/GreyPanel/Score.text = "Score : " + str(Main.win_score)
	$Control/GreyPanel/Coins.text = "Coins : " + str(Main.win_coins)
	$Control/GreyPanel/Time.text = "Time : " + str(set_time())
	$Control/GreyPanel/Kill.text = "Kill : " + str(Main.win_kill)

func _update_level(number):
	if number == "LevelOne":
		level = 2
	if number == "LevelTwo":
		level = 3

func time(type):
	if type == "hours":
		return int(time_win / 3600)
	if type == "minutes":
		return int((time_win % 3600) / 60)
	if type == "seconds":
		return float(time_win % 60) 

func set_time():
	var hours = time("hours")
	var minutes = time("minutes")
	var seconds = time("seconds")
	
	return str(hours) + "h - " + str(minutes) + "m - " + str(seconds) +"s"

func _on_continue_pressed():
	$Click.play()
	await get_tree().create_timer(0.1).timeout
	if level == 2:
		get_tree().change_scene_to_file("res://Scenes/World/LevelTwo.tscn")
	if level == 3:
		get_tree().change_scene_to_file("res://Scenes/World/LevelThree.tscn")


func _on_restart_pressed():
	$Click.play()
	await get_tree().create_timer(0.1).timeout
	Main.restart()


func _on_main_menu_pressed():
	$Click.play()
	await get_tree().create_timer(0.1).timeout
	Main.quit()
