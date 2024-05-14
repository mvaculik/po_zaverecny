extends Control

func _process(_delta):
	$Control/Score.text = "SCORE : " + str(Main.lose_score)

func _on_restart_pressed():
	$Click.play()
	await get_tree().create_timer(0.1).timeout
	Main.paused()
	Main.restart()


func _on_exit_pressed():
	$Click.play()
	await get_tree().create_timer(0.1).timeout
	Main.paused()
	Main.quit()
