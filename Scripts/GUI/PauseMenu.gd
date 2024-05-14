extends Control

func _on_resume_pressed():
	$Click.play()
	Main.resume()


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
