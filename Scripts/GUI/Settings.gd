extends Control

@onready var music =  $Music/MusicSlider
@onready var sfx =  $Sfx/SfxSlider
@onready var song = $Songs/Song
@onready var option = $Songs/SongOption

var max_value
var min_value
var bg_bus = AudioServer.get_bus_index("Bg")
var sfx_bus = AudioServer.get_bus_index("Sfx")
var songs = [
	preload("res://PirateSprite/Sounds/Backsound/Overworld/We're Bird People Now.ogg"),
	preload("res://PirateSprite/Sounds/Backsound/Overworld/Long Road Ahead.ogg"),
	preload("res://PirateSprite/Sounds/Backsound/Overworld/On The Move.ogg"),
	preload("res://PirateSprite/Sounds/Backsound/Overworld/World Travelers.ogg")
]

func _ready():
	max_value = music.max_value
	min_value = music.min_value
	music.value = AudioServer.get_bus_volume_db(bg_bus)
	sfx.value = AudioServer.get_bus_volume_db(sfx_bus)
	option.selected = Main.song_index
	
func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/TitleScreen.tscn")

func _on_music_slider_value_changed(value):
	$Music/Slider.play()
	$Music/PersenMusic.text = str(int((value - min_value) / (max_value - min_value) * 100)) + "%"
	AudioServer.set_bus_volume_db(bg_bus, value)


func _on_sfx_slider_value_changed(value):
	$Sfx/Slider2.play()
	$Sfx/PersenSfx.text = str(int((value - min_value) / (max_value - min_value) * 100)) + "%"
	AudioServer.set_bus_volume_db(sfx_bus, value)

# percentage = (saved_vol - min_value) / (max_value - min_value) * 100

func _on_song_option_item_selected(index):
	var value = songs[index]
	Main.update_song(value)
	Main.song_index = index
	song.set_stream(value)
	song.play()
