extends CharacterBody2D

@onready var fill_max = $healthbar/ColorRect.size.x

@export var speed = -60
@export var max_health = 3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = false
var dead = false
var health = 0
var hit = false
var can_attack = true
var current_speed = 0.0
var fill_amount : float

func _ready():
	health = max_health
	$AnimationPlayer.play("Run")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if !$DetectFloor.is_colliding() && is_on_floor() or $DetectWall.is_colliding() && is_on_floor() :
		flip()

	velocity.x = speed
	move_and_slide()

func update_healthbar(current_health):
	fill_amount = (float(current_health) / max_health	) * fill_max
	$healthbar/ColorRect.size.x = fill_amount

func flip():
	direction = !direction
	
	scale.x = abs(scale.x) * -1
	if direction:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func die():
	Main.update_enemy(1)
	Main.update_score(50)
	dead = true
	speed = 0
	$AnimationPlayer.play("Dead")

func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead && can_attack:
		area.get_parent().take_damage(1)

func take_damage(damage_amount):
	if !dead:
		$AnimationPlayer.play("Hit")
		health -= damage_amount
		update_healthbar(health)
		
		if health <= 0:
			die()

func get_hit():
	hit = !hit
	
	if hit:
		current_speed = speed
		speed = 0
		can_attack = false
	else:
		speed = current_speed
		can_attack = true
		$AnimationPlayer.play("Run")
