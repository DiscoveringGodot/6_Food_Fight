extends "res://Scenes/Characters/Character.gd"

var can_refill

# Animation variables
var movement_rate = 0 # how much you're moving, from 0 to 1
var action_rate = 0 # -1 is shoot, 1 is search

var facing_direction 

var cam_xform = Vector3(0,0,0)

func _ready():
	facing_direction = 0
	can_refill = false
#	$PlayerModel/Armature/Human_Mesh.set_surface_material(0, load(Customisations.Player_materials))


func _physics_process(delta):
	cam_xform = $Camera.global_transform
	if is_on_floor():
		move()
	fall()
	jump()
	move_and_slide(motion * speed, UP)
	reload()
	animate()


func move():
	var camera_forward = cam_xform.basis[2]
	if Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		motion = -camera_forward
		facing_direction = 0
	elif Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
		motion = camera_forward
		facing_direction = PI
	else:
		motion = Vector3(0,0,0)
	
	var camera_right = cam_xform.basis[0]
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion -= cam_xform.basis[0]
		facing_direction = PI *0.5
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion += cam_xform.basis[0]
		facing_direction = PI *1.5
		
	
	motion = motion.normalized()

	if motion.length() > 0.25:
		movement_rate += 0.1
	else:
		movement_rate -= 0.2

	movement_rate = clamp(movement_rate, 0, 1)
#	$PlayerModel.look_at( -motion, Vector3(0,1,0))
	$PlayerModel.rotation.y = facing_direction
	



func fall():
	if not is_on_floor():
		motion.y -= GRAVITY
	else:
		motion.y = 0

func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		motion.y = JUMP_VELOCITY 


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
	var animation = $PlayerModel/AnimationTreePlayer
	if can_refill:
		action_rate += 0.25
	
	action_rate = clamp(action_rate, -1, 1)
	
	action_rate = lerp(action_rate, 0, 0.125)
	
	animation.blend2_node_set_amount("Move", movement_rate)
	animation.blend3_node_set_amount("State", action_rate)