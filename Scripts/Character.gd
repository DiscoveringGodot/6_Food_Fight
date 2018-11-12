extends KinematicBody

const PROJECTILE_SPEED = 50

func fire():
	var bullet = load("res://Scenes/Ammo/Projectile.tscn").instance()
	add_child(bullet)
	bullet.set_as_toplevel(true)
	bullet.global_transform = $Forward.global_transform
	var character_forward = get_global_transform().basis[2].normalized()
	bullet.set_linear_velocity(character_forward * PROJECTILE_SPEED)
	bullet.add_collision_exception_with(self)