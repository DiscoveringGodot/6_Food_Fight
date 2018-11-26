extends RigidBody


func _on_VisibilityNotifier_camera_exited(camera):
	queue_free()


func _on_Timer_timeout():
	queue_free()


func hurt(hurt_by):
	$Timer.start()
	$AudioStreamPlayer3D.play()