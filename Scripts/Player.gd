extends KinematicBody

const SPEED = 10
const UP = Vector3(0,1,0)

var motion = Vector3()
var facing_direction = 0


func _process(delta):
	move()
	face_forward()


func move():
	motion = Vector3(0,0,0)
	if Input.is_action_pressed("forward") and not Input.is_action_pressed("back"):
		motion.z = -1
		facing_direction = 0
	if Input.is_action_pressed("back") and not Input.is_action_pressed("forward"):
		motion.z = 1
		facing_direction = PI
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -1
		facing_direction = PI * 0.5
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = 1
		facing_direction = PI * 1.5
	
	move_and_slide(motion * SPEED, UP)


func face_forward():
	$Armature.rotation.y = facing_direction