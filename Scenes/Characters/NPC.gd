extends "res://Scenes/Characters/Character.gd"

export var fire_delay = 0.1

func _enter_tree():
	$Timer.wait_time = fire_delay

func _process(delta):
	if $RayCast.is_colliding():
		$Timer.start()

func _on_Timer_timeout():
	fire()

