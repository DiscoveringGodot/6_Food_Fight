extends CanvasLayer

func _input(event):
	if Input.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		toggle_pause_menu()


func toggle_pause_menu():
	if get_tree().paused:
		$Popup.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		$Popup.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_Fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_Quit_pressed():
	get_tree().quit()
