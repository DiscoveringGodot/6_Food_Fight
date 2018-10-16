extends RigidBody

var fired_by = 0

func _enter_tree(player_id):
	fired_by = player_id
	$Timer.start()


func _on_Timer_timeout():
	queue_free()

#What happens if a character is hit by food
func _on_Projectile_body_shape_entered(body_id, body, body_shape, local_shape):
	if body is KinematicBody:
		body.hurt(fired_by)
	if body.has_method("despawn"):
		body.despawn(fired_by)