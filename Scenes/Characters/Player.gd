extends "res://Scenes/Characters/Character.gd"

var can_refill

# Animation variables
var movement_rate = 0 # how much you're moving, from 0 to 1
var action_rate = 0 # -1 is shoot, 1 is search

var facing_dir 
var upward_movement =0
var vel = Vector3()
var dir = Vector3()

const ACCEL= 4.5
const DEACCEL= 16

var camera

#var cam_xform = Vector3(0,0,0)


func _ready():
	var camera = $Camera
	facing_dir = 0
	can_refill = false
	if Customisations.Player_materials != null:
		$PlayerModel/Armature/Human_Mesh.set_surface_material(0, load(Customisations.Player_materials))


func _physics_process(delta):
	motion.x = 0
	motion.z = 0
#	cam_xform = $Camera.get_global_transform()
	move(delta)
	fall()
#	move_and_slide(vel, UP)
	reload()
	animate()


func move(delta):
	var dir = Vector3()
	var movement_vector = Vector2()
	var camera_xform = $Camera.get_global_transform()
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
	
	movement_vector = movement_vector.normalized()
	
	dir += -camera_xform.basis.z.normalized() * movement_vector.y
	dir += -camera_xform.basis.x.normalized() * movement_vector.x
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		vel.y = JUMP_SPEED
	
#	motion = motion.normalized()
	dir.y = 0
	dir = dir.normalized()
	
	vel.y += delta*GRAVITY
	var hvel = vel
	hvel.y = 0
	
	var target = dir
	target *= MAX_SPEED
	
	var accel
	if dir.dot(hvel) > 0:
		 accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel*delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel,UP)


	$PlayerModel.rotation.y = facing_dir


func fall():
#	if not is_on_floor():
#		motion.y -= GRAVITY
#	elif is_on_floor() and motion.y < 0:
#		motion.y = 0
	pass


func _input(event):
	if Input.is_action_just_pressed("fire"):
		try_to_fire()


func try_to_fire():
	if ammo > 0:
		fire()
		ammo -=1
		update_gui()
		action_rate = -1


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


func _on_Area_body_exited(body):
	$Timer.stop()
	can_refill = false


func update_gui():
	get_tree().call_group("GUI", "update_gui", ammo)


func _on_Area_body_entered(body):
	if check_ammo() and ammo < max_ammo:
		$Timer.start()
		can_refill = true


func refresh_refill():
	get_node("../Gui").refill($Timer.wait_time - $Timer.time_left)


func animate():
	if vel.length() > 0.25:
		movement_rate += 0.1
	else:
		movement_rate -= 0.2

	movement_rate = clamp(movement_rate, 0, 1)
	var animation = $PlayerModel/AnimationTreePlayer
	if can_refill:
		action_rate += 0.25
	
	action_rate = clamp(action_rate, -1, 1)
	
	action_rate = lerp(action_rate, 0, 0.125)
	
	animation.blend2_node_set_amount("Move", movement_rate)
	animation.blend3_node_set_amount("State", action_rate)
	
	

