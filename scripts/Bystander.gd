extends RigidBody

func _on_VisibilityNotifier_camera_exited(camera):
	queue_free()


func hurt(fired_by):
	$Timer.start()
	$AudioStreamPlayer3D.play()


func _on_Timer_timeout():
	call_deferred("queue_free")