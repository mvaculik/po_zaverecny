extends Node

signal health
signal collected
signal potion(name_potion)
signal score(player_score)
signal cutscene
signal dialog(interval)
signal level(number)
signal chest_key

var checkpoint : CheckPoint
var player : Player

var isPaused = false
var position_cutscene
var backsound
var song_index = 0
var win_score = 0
var lose_score = 0
var win_coins = 0
var win_kill = 0
var start_time = 0
var end_time = 0

func play_time():
	start_time = Time.get_ticks_msec() / 1000.0

func win_time():
	end_time =  int(Time.get_ticks_msec() / 1000.0 - start_time)

func respawn_player():
	if checkpoint != null:
		player.position = checkpoint.global_position

func collected_coins():
	emit_signal("collected")

func update_health(amount):
	emit_signal("health", amount)

func update_potion(name_potion):
	emit_signal("potion", name_potion)

func update_score(player_score):
	emit_signal("score", player_score)

func play_cutscene():
	emit_signal("cutscene")

func update_enemy(value):
	win_kill += value

func update_song(value):
	backsound = value

func update_dialog(interval):
	emit_signal("dialog", interval)

func update_level(number):
	emit_signal("level", number)

func update_chest_key():
	emit_signal("chest_key")

func resume():
	paused()

func paused():
	isPaused = !isPaused
	get_tree().paused = isPaused

func restart():
	get_tree().reload_current_scene()

func quit():
	get_tree().change_scene_to_file("res://Scenes/UI/TitleScreen.tscn")
