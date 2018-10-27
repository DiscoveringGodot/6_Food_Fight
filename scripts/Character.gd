extends KinematicBody

const UP = Vector3(0,1,0)
const GRAVITY = -45


var player_id = 0

var motion = Vector3()
var MAX_SPEED = 20

var lives = 3
var can_fire = true

var ammo_types = {}
var ammo_collection_speed = 1
var ammo = 0
var max_ammo = 5
var projectile_speed = 50


func _enter_tree():
	ammo_types = file_grabber.get_files("res://Scenes/Ammo/Ammo_Scenes/")
	randomize()
	$Timer.wait_time = ammo_collection_speed


func hurt(hurt_by):
	if player_id != hurt_by: # Why are you hitting yourself?
		$AudioStreamPlayer3D.play()
		lives-= 1
		update_lives()
		check_lives()

func fire():
	var bullet = load(ammo_types [randi() % ammo_types.size()] ).instance()
	add_child(bullet)
	bullet.fired_by = player_id
	bullet.set_as_toplevel(true)
	bullet.global_transform = $Forward.global_transform
	bullet.set_linear_velocity(get_global_transform().basis[2].normalized() * projectile_speed)
	bullet.add_collision_exception_with(self) 


func check_lives():
	if lives == 0:
		die()

func _on_CanFire_timeout():
	can_fire = true
