extends CanvasLayer


func _input(event):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			$Popup.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			$Popup.hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_Button1_pressed():
	 OS.window_fullscreen = !OS.window_fullscreen
