extends "res://scripts/Character.gd"

export var fire_delay = 0.1

signal remove_enemy

func _enter_tree():
	player_id = 2
	$Timer.wait_time = fire_delay
	$Robot/RobotArmature/AnimationPlayer.get_animation("Robot_Running").set_loop(true)
	$Robot/RobotArmature/AnimationPlayer.play("Robot_Running")
	var gamestate = get_tree().get_root().find_node("Game", true, false)
	connect("remove_enemy", gamestate, "remove_enemy")

func _process(delta):
	if $RayCast.is_colliding():
		$Timer.start()

func _on_Timer_timeout():
	fire()

func die():
	emit_signal("remove_enemy")
	queue_free()


func update_lives():
	if lives > 0:
		var life = $Lives.get_child(0).get_child(0)
		life.play("LoseLife")
		