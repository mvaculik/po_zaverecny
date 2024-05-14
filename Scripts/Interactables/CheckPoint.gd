extends Node2D
class_name CheckPoint

@export var dialog = false
@export var activated = false
@export var dialogIndex = "start"

func _on_activated_area_entered(area):
	Main.checkpoint = self
	if area.get_parent() is Player && !activated:
		activated = true
		$AnimationPlayer.play("Activated")
		$Activate.play()
	if area.get_parent() is Player && dialog:
		Main.update_dialog(dialogIndex)
		dialog = false
