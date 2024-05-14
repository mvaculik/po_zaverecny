extends Node2D

var available = true

func _on_timer_timeout():
	available = true
	$AnimationPlayer.play("Idle")
	Main.update_potion("endAttackPotion")
	show()

func _on_getbox_area_entered(area):
	if area.get_parent() is Player && available:
		available = false
		Main.update_potion("AttackPotion")
		$Timer.start()
		$AnimationPlayer.play("Get")
