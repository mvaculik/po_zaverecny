extends Node2D

@onready var spawn = global_position
@export var speed = 160.0
var current_speed = 0.0

func _physics_process(delta):
	position.y += current_speed * delta

func fall():
	$Fall.play()
	current_speed = speed


func _on_hitbox_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().take_damage(1)


func _on_playerd_detect_area_entered(area):
	if area.get_parent() is Player:
		$AnimationPlayer.play("Shake")
		await get_tree().create_timer(5).timeout
		position = spawn
		current_speed = 0.0
