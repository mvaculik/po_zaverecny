extends Node2D

@export var speed_ship = 0.2
@onready var track = $Path2D/PathFollow2D
var target_offset = 1.0
var current_offset = 0.0
var on_area = false

func _process(delta):
	if on_area:
		current_offset = track.get_progress_ratio()
		if current_offset < target_offset:
			current_offset = current_offset + speed_ship * delta
			track.set_progress_ratio(current_offset)

func _on_moving_area_entered(area):
	if area.get_parent() is Player && !on_area:
		Main.play_cutscene()
		area.get_parent().can_move = false
		await get_tree().create_timer(0.5).timeout
		on_area = true
		$Path2D/PathFollow2D/AnimationPlayer.play("Move")
		Main.update_level("LevelOne")
