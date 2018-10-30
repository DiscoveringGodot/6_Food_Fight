extends Camera

export var mouse_sensitivity = 1200

#onready var Player = get_parent()


func _input(event):
	if event is InputEventMouseMotion:
		return mouse(event)


func mouse(event):
	set_rotation(look_leftright_rotation(-event.relative.x / mouse_sensitivity))

	##
	## Now we can simply set our y-rotation for the camera, and let godot
	## handle the transformation of both together
	set_rotation(look_updown_rotation(-event.relative.y / mouse_sensitivity))


func look_updown_rotation(rotation = 0):
	"""
	Get the new rotation for looking up and down
	"""
	var newRotation = get_rotation() + Vector3(rotation, 0, 0)

	##
	## We don't want the player to be able to bend over backwards
	## neither to be able to look under their arse.
	## Here we'll clamp the vertical look to 90° up and down
	newRotation.x = clamp(newRotation.x, PI / -2, PI / 2)
	
	return newRotation



func look_leftright_rotation(rotation = 0):
	"""
	Get the new rotation for looking left and right
	"""
	return get_rotation() + Vector3(0, rotation, 0)


func _enter_tree():
	"""
	Hide the mouse when we start
	"""
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _leave_tree():
	"""
	Show the mouse when we leave
	"""
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
