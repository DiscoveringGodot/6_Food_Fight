extends KinematicBody

const PROJECTILE_SPEED = 50

var ammo_types = {}
var can_fire = true

func _enter_tree():
	ammo_types = file_grabber.get_files("res://Scenes/Ammo/Ammo_models/")
	randomize()

func fire():
	var random_bullet = ammo_types[randi() % ammo_types.size()]
	var bullet = load(random_bullet).instance()
	add_child(bullet)
	bullet.set_as_toplevel(true)
	bullet.global_transform = $Forward.global_transform
	var character_forward = get_global_transform().basis[2].normalized()
	bullet.set_linear_velocity(character_forward * PROJECTILE_SPEED)
	bullet.add_collision_exception_with(self)

func _on_CanFire_timeout():
	can_fire = true
