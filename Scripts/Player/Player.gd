extends CharacterBody2D
class_name Player

@onready var sprite = $Sprite2D
@onready var animation = $AnimationPlayer

@export var speed = 300.0
@export var jump_height = -400.0
@export var attacking = false
@export var hit = false
@export var jump_effect = -150
@export var attack_effect = 2
@export var speed_effect = 50

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var health = 0
var max_health = 5
var can_move = true
var can_take_damage = true
var kill = 0
var  on_win_area = false
var damage_attack = 1

func _ready():
	Main.player = self
	health = max_health
	Main.cutscene.connect(_on_cutscene)
	Main.potion.connect(_on_effect_potion)
	Main.dialog.connect(_on_dialog)

func _process(_delta):
	if health > max_health:
		health = max_health
	if Input.is_action_just_pressed("attack") && !hit && can_move && !on_win_area:
		attack()

func _input(event):
	if event.is_action_pressed("down") && is_on_floor():
		position.y += 5

func _physics_process(delta):
	if Input.is_action_pressed("left") && can_move && !on_win_area:
		sprite.scale.x = abs(sprite.scale.x) * -1
		$AttackArea.scale.x = abs($AttackArea.scale.x) * -1
	if Input.is_action_pressed("right") && can_move && !on_win_area:
		sprite.scale.x = abs(sprite.scale.x)
		$AttackArea.scale.x = abs($AttackArea.scale.x)


	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor() and can_move and !on_win_area:
		$Jump.play()
		velocity.y = jump_height

	var direction = Input.get_axis("left", "right")
	if direction && can_move && !on_win_area:
		velocity.x = direction * speed
	if !direction && !can_move && !on_win_area:
		velocity.x = move_toward(velocity.x, 0, speed)
	if !direction && can_move && !on_win_area:
		velocity.x = move_toward(velocity.x, 0, speed)

	update_animation()
	move_and_slide()
	
	if position.y > 800:
		take_damage(1)
		Main.respawn_player()

func update_animation():
	if !attacking && !hit:
		if velocity.x != 0:
			$AnimationPlayer.play("Run")
		else:
			$AnimationPlayer.play("Idle")

		if velocity.y < 0:
			$AnimationPlayer.play("Jump")
		if velocity.y > 0:
			$AnimationPlayer.play("Fall")

func attack():
	var overlapping_objects = $AttackArea.get_overlapping_areas()
	
	for area in overlapping_objects:
		if area.get_parent().is_in_group("Enemies"):
			area.get_parent().take_damage(damage_attack)
	
	attacking = true
	$AnimationPlayer.play("Attack")

func take_damage(amount):
	if can_take_damage:
		iframes()
		hit = true
		attacking = false
		$Hit.play()
		$AnimationPlayer.play("Hit")
		health -= amount
		Main.update_health(-1)
	
	if health <= 0 :
		die()


func iframes():
	can_take_damage = false
	await get_tree().create_timer(0.5).timeout
	can_take_damage = true

func die():
	Main.paused()

func _on_cutscene():
	$Camera2D.enabled = false
	Main.position_cutscene = position

func _on_dialog(interval):
	if interval == "end" :
		can_move = true
	else :
		can_move = false

func _on_effect_potion(potion_effect):
	if potion_effect == "JumpPotion":
		jump_height += jump_effect
	if potion_effect == "AttackPotion":
		damage_attack += attack_effect
	if potion_effect == "SpeedPotion":
		speed += speed_effect
	if potion_effect == "endAttackPotion":
		damage_attack -= attack_effect
	if potion_effect == "endJumpPotion":
		jump_height -= jump_effect
	if potion_effect == "endSpeedPotion":
		speed -= speed_effect
