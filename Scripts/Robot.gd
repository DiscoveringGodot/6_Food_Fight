extends "res://Scripts/Character.gd"

signal remove_enemy

func _ready():
	$RobotArmature/AnimationPlayer.get_animation("Robot_Running").set_loop(true)
	character_type = CHARACTER_TYPES.npc
	var gamestate = get_parent().get_parent()
	connect("remove_enemy", gamestate, "remove_enemy")


func _physics_process(delta):
	if $RayCast.is_colliding() and can_fire:
		fire()
		can_fire = false
		$CanFire.start()


func update_lives():
	if lives > 0 :
		var life = $Lives.get_child(0).get_child(0)
		life.play("lose_life")


func die():
	emit_signal("remove_enemy")
	queue_free()