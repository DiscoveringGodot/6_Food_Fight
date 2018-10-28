extends "res://scripts/Character.gd"

# State variables
var can_refill = false # can you pick up ammo?
var can_move = true #

# Animation variables
var movement_state = 0 # blend of how much you're moving: from 0 to 1
var action_state = 0 # -blend of your state: 1 is shoot, 0 is move/idle, 1 is search

const MIN_BLEND_SPEED = 0.125
const BLEND_TO_RUN = 0.1
const BLEND_TO_IDLE = 0.2
const BLEND_TO_RELOAD = 0.25

# Movement variables
var facing_dir = 0 # instance variable to make sure we stay facing the last direction we moved in
var vel = Vector3()
var dir = Vector3()

# Ammo variables
var ammo = 0 # how much ammo I have
var max_ammo = 5 # how much ammo I can carry

# Movement constants
const ACCEL= 5
const DEACCEL= 16
const JUMP_SPEED = 15


func _ready():
	character_type = CHARACTER_TYPES.Player
	if Customisations.Player_materials != null: # error catching
		$Armature/Mesh.set_surface_material(0, load(Customisations.Player_materials))
	update_lives()


func _physics_process(delta):
	motion.x = 0
	motion.z = 0
	if can_move:
		move(delta)
		animate()
	reload()


func move(delta):
	var movement_dir = get_2D_movement_dir()
	var dir = Vector3()
	var camera_xform = $Camera.get_global_transform()
	
	dir -= camera_xform.basis.z.normalized() * movement_dir.y
	dir -= camera_xform.basis.x.normalized() * movement_dir.x

	dir = move_vertically(dir, delta)
	vel = accellerate(delta, dir) # must pass dir or we won't move (x * 0 = 0)
	move_and_slide(vel,UP)
	$Armature.rotation.y = facing_dir


func get_2D_movement_dir():
	var movement_vector = Vector2()

	if Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		movement_vector.y += 1
		facing_dir = 0
	if Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
		movement_vector.y -= 1
		facing_dir = PI
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		movement_vector.x += 1
		facing_dir = PI *0.5
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		movement_vector.x -= 1
		facing_dir = PI *1.5

	return movement_vector.normalized()


func move_vertically(dir, delta):
	vel.y += delta  *  GRAVITY

	if Input.is_action_just_pressed("jump") and is_on_floor():
		vel.y = JUMP_SPEED
	elif is_on_floor():
		vel.y = 0

	dir.y = 0
	dir = dir.normalized()
	return dir


func accellerate(delta, dir):
	var vel_2D = vel # make a new variable to work on horizontal velocity
	vel_2D.y = 0 # seperate all vertical velocity

	var target = dir
	target *= MAX_SPEED
	
	var accel
	if dir.dot(vel_2D) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	vel_2D = vel_2D.linear_interpolate(target, accel * delta)
	vel.x = vel_2D.x
	vel.z = vel_2D.z
	
	return vel


func _input(event):
	if Input.is_action_just_pressed("fire"):
		try_to_fire()


func try_to_fire():
	if ammo > 0 and can_fire:
		fire()
		can_fire = false
		$CanFire.start()
		ammo -= 1
		update_gui()
		action_state = -1


func _on_Timer_timeout():
	ammo += 1
	update_gui()
	if check_ammo():
		$Timer.start()
	else:
		$Timer.stop()


func check_ammo():
	if ammo < max_ammo:
		return true


func reload():
	if can_refill == true:
		refresh_refill()


func Refil_entered():
	if check_ammo() and ammo < max_ammo:
		$Harp.play()
		$Timer.start()
		can_refill = true


func Refil_exited():
	$Timer.stop()
	can_refill = false
	get_tree().call_group("GUI", "empty_GUI")
	$Harp.stop()


func update_gui():
	get_tree().call_group("GUI", "update_gui", ammo)


func update_lives():
	if character_type == CHARACTER_TYPES.Player:
		get_tree().call_group("GUI", "update_lives", lives)


func refresh_refill():
	get_node("../Gui").refill($Timer.wait_time - $Timer.time_left)


func animate():
	var horizontal_vel = Vector3(vel.x, 0, vel.z)
	if vel.length() > MIN_BLEND_SPEED: # comment and define as a const
		movement_state += BLEND_TO_RUN
	else:
		movement_state -= BLEND_TO_IDLE

	movement_state = clamp(movement_state, 0, 1)
	var animation = $Armature/AnimationTreePlayer
	if can_refill:
		action_state += BLEND_TO_RELOAD
	
	action_state = clamp(action_state, -1, 1)
	
	action_state = lerp(action_state, 0, 0.125)
	
	animation.blend2_node_set_amount("Move", movement_state)
	animation.blend3_node_set_amount("State", action_state)


func die():
	can_move = false
	$Armature/AnimationTreePlayer.active = false
	$Armature/AnimationPlayer.play("Death")


func game_over():
	get_tree().change_scene("res://Scenes/GameOver/GameOver.tscn")