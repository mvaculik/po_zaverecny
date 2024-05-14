extends CanvasLayer

@export var max_healthbar = 5
@onready var coin_count = $Coins/CoinCount
@onready var healthbar = $Lifebars/Health
@onready var score_count = $Score/PlayerScore
@onready var song = $BGMusic
@onready var dialog1 = $Dialog/Dialog1
@onready var dialog2 = $Dialog/Dialog2
@onready var dialog3 = $Dialog/Dialog3
@onready var dialog4 = $Dialog/Dialog4
@onready var dialog5 = $Dialog/Dialog5
@onready var dialog6 = $Dialog/Dialog6
@onready var dialog_ship1 = $Dialog/DialogShip1
@onready var dialog_ship2 = $Dialog/DialogShip2
@onready var dialog_cave =$Dialog/DialogCave
@onready var dialog_chest = $Dialog/DialogChest
@onready var potion = $Lifebars/PotionEffect

var win_screen = preload("res://Scenes/UI/WinScreen.tscn").instantiate()
var game_over = preload("res://Scenes/UI/GameOver.tscn").instantiate()
var die = preload("res://PirateSprite/Sprites/UI/Life Bars/Big Bars/2.png")
var default_song = preload("res://PirateSprite/Sounds/Backsound/Overworld/We're Bird People Now.ogg")
var pause_menu = preload("res://Scenes/UI/PauseMenu.tscn").instantiate()

var coins = 0
var score = 0
var win = false
var dead = false
var isShow = false

func  _ready():
	Main.collected.connect(_on_coin_collected)
	Main.health.connect(_update_life_bars)
	Main.potion.connect(_update_potion_effect)
	Main.score.connect(_update_score)
	Main.cutscene.connect(_winning)
	Main.dialog.connect(_on_dialog)
	healthbar.scale.x *= max_healthbar
	update_backsound()

func _process(_delta):
	if dead :
		Main.lose_score = score
	#Untuk cek pause game
	if !Main.isPaused && has_node("PauseMenu"):
		remove_child(pause_menu)
		isShow = !isShow
	
	# untuk mengurus pause ketika pencet esc
	if Input.is_action_just_pressed("pause") && !win:
		if(!isShow) : 
			add_child(pause_menu) 
			isShow = !isShow
		else : 
			remove_child(pause_menu)
			isShow = !isShow
		Main.paused()

	if healthbar.scale.x < 1 && !dead:
		$Lifebars/Start.set_texture(die)
		add_child(game_over)
		$BGMusic.stop()
		dead = true

func  _on_coin_collected():
	coins += 1
	coin_count.text = str(coins)

func _update_potion_effect(name_potion):
	if name_potion == "JumpPotion":
		$Lifebars/PotionEffect/JumpPotion.visible = true
	elif name_potion == "SpeedPotion":
		$Lifebars/PotionEffect/SpeedPotion.visible = true
	elif name_potion == "AttackPotion":
		$Lifebars/PotionEffect/AttackPotion.visible = true
	else:
		$Lifebars/PotionEffect/JumpPotion.visible = false
		$Lifebars/PotionEffect/SpeedPotion.visible = false
		$Lifebars/PotionEffect/AttackPotion.visible = false

func _update_life_bars(amount):
	healthbar.scale.x += amount
	if healthbar.scale.x >= max_healthbar:
		healthbar.scale.x = max_healthbar
	if healthbar.scale.x < 1:
		healthbar.scale.x = 0

func _update_score(player_score):
	score += player_score
	score_count.text = "Score : " + str(score)

func _winning():
	if !win:
		win = true
		add_child(win_screen)
		Main.win_time()
		Main.win_score = score
		Main.win_coins = coins

func _on_dialog(interval):
	if interval == "Dialog1" :
		dialog1.visible = true
	if interval == "Dialog2" :
		dialog2.visible = true
	if interval == "Dialog3" :
		dialog3.visible = true
	if interval == "Dialog4" :
		dialog4.visible = true
	if interval == "Dialog5" :
		dialog5.visible = true
	if interval == "Dialog6" :
		dialog6.visible = true
	if interval == "DialogShip1":
		dialog_ship1.visible = true
	if interval == "DialogShip2":
		dialog_ship2.visible = true
	if interval == "DialogCave":
		dialog_cave.visible = true
	if interval == "ChestLocked":
		dialog_chest.visible = true
	if interval == "end" :
		dialog1.visible = false
		dialog2.visible = false
		dialog3.visible = false
		dialog4.visible = false
		dialog5.visible = false
		dialog6.visible = false
		dialog_ship1.visible = false
		dialog_ship2.visible = false
		dialog_cave.visible = false
		dialog_chest.visible = false

func update_backsound():
	if Main.song_index == 0:
		song.set_stream(default_song)
	else :
		song.set_stream(Main.backsound)
	song.play()
