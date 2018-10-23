extends "res://Scenes/Characters/Character.gd"

export var fire_delay = 0.1

func _enter_tree():
	$Timer.wait_time = fire_delay
	$Robot/RobotArmature/AnimationPlayer.get_animation("Robot_Running").set_loop(true)
	$Robot/RobotArmature/AnimationPlayer.play("Robot_Running")

func _process(delta):
	if $RayCast.is_colliding():
		$Timer.start()

func _on_Timer_timeout():
	fire()

func die():
	queue_free()