extends KinematicBody

const PROJECTILE_SPEED = 50

enum CHARACTER_TYPES {player, npc}
var character_type

var ammo_types = {}
var can_fire = true

var lives = 3

func _enter_tree():
	ammo_types = file_grabber.get_files("res://Scenes/Ammo/Ammo_models/")
	randomize()

func fire():
	var random_bullet = ammo_types[randi() % ammo_types.size()]
	var bullet = load(random_bullet).instance()
	add_child(bullet)
	bullet.fired_by  = character_type
	bullet.set_as_toplevel(true)
	bullet.global_transform = $Forward.global_transform
	var character_forward = get_global_transform().basis[2].normalized()
	bullet.set_linear_velocity(character_forward * PROJECTILE_SPEED)
	bullet.add_collision_exception_with(self)

func _on_CanFire_timeout():
	can_fire = true


func hurt(hurt_by):
	if character_type != hurt_by:
		lives -= 1
		$HurtSFX.play()
		check_lives()
	update_lives()
	

func check_lives():
	if lives < 1:
		die()
	
	
	
	