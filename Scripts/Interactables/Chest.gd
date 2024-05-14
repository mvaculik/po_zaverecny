extends StaticBody2D

var have_key = false
var dialog = true

func _ready():
	Main.chest_key.connect(_get_key)

func _get_key():
	have_key = true

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !have_key && dialog:
		Main.update_dialog("ChestLocked")
		dialog = false
	
	if area.get_parent() is Player && have_key:
		$AnimationPlayer.play("Unlocked")
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scenes/UI/Epilog.tscn")
