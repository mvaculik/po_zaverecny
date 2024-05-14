extends Node2D

func _on_get_box_area_entered(area):
	if area.get_parent() is Player :
		Main.collected_coins()
		Main.update_score(10)
		$AnimationPlayer.play("Get")
