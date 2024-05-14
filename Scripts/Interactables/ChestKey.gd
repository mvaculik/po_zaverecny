extends Node2D

var available = true

func _on_get_area_entered(area):
	if area.get_parent() is Player && available:
		Main.update_chest_key()
		available = false
		$AnimationPlayer.play("Get")
