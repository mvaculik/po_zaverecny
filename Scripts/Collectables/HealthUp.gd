extends Node2D



func _on_get_box_area_entered(area):
	if area.get_parent() is Player:
		$AnimationPlayer.play("Get")
		area.get_parent().health += 1
		Main.update_health(1)
