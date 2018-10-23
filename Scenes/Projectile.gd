extends RigidBody

var fired_by = 0


func _enter_tree():
	$Timer.start()
 

func _on_Timer_timeout():
	queue_free()

#What happens if a character is hit by food
func _on_Projectile_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.has_method("hurt"):
		body.hurt(fired_by)