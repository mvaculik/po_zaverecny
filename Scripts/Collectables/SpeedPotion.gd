extends Node2D

var available = true

func _on_getbox_area_entered(area):
	if area.get_parent() is Player && available:
		available = false
		Main.update_potion("SpeedPotion")
		$Timer.start()
		$AnimationPlayer.play("Get")


func _on_timer_timeout():
	$AnimationPlayer.play("Idle")
	Main.update_potion("endSpeedPotion")
	show()
	available = true
