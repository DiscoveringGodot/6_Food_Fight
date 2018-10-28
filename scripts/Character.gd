extends KinematicBody

const UP = Vector3(0,1,0)
const GRAVITY = -45
const MAX_SPEED = 20
const ammo_collection_speed = 1 # How long it takes to collect ammo in second
const projectile_speed = 50

enum CHARACTER_TYPES {Player, NPC}
var character_type 

var motion = Vector3()

var lives = 3
var can_fire = true

var ammo_types = {}


# fires before ready is called
func _enter_tree():
	ammo_types = file_grabber.get_files("res://Scenes/Ammo/Ammo_Scenes/")
	randomize()
	$Timer.wait_time = ammo_collection_speed


func hurt(hurt_by):
	if character_type!= hurt_by: # Why are you hitting yourself?
		$AudioStreamPlayer3D.play()
		lives -= 1
		update_lives()
		check_lives()

func fire():
	var random_bullet = ammo_types [randi() % ammo_types.size()]
	var bullet = load(random_bullet).instance()
	add_child(bullet)
	bullet.fired_by = character_type
	bullet.set_as_toplevel(true) # move out of your parent's place
	bullet.global_transform = $Forward.global_transform
	var character_forward = get_global_transform().basis[2].normalized()
	bullet.set_linear_velocity(character_forward * projectile_speed)
	bullet.add_collision_exception_with(self) 


func check_lives():
	if lives == 0:
		die()

func _on_CanFire_timeout():
	can_fire = true
