extends KinematicBody

const UP = Vector3(0,1,0)

export var player_id = 0

var motion = Vector3()
var speed = 10

var lives = 3

var projectile_speed = 50

var ammo_collection_speed = 1
var ammo = 0
var max_ammo = 3
var ammo_types


func _ready():
	ammo_types = get_parent().ammo_types
	$Timer.wait_time = ammo_collection_speed
	
func hurt(hurt_by):
	$AudioStreamPlayer3D.play()
	get_parent().update_score(hurt_by, true)

func fire():
	randomize()
	var bullet = ammo_types[randi() %ammo_types.size()-1].instance()
	var forward = $Forward
	
	get_parent().add_child(bullet)
	bullet.set_transform(forward.get_global_transform())
	bullet.set_linear_velocity(forward.get_global_transform().basis[2].normalized() * projectile_speed)
	bullet.add_collision_exception_with(self) 
	bullet.fired_by = player_id


func check_lives():
	if lives == 0:
		queue_free()