extends Spatial

func _ready():
	$RobotArmature/AnimationPlayer.get_animation("Robot_Dance").loop = true
