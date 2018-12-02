extends Spatial

var enemy_count


func _ready():
	instance_PC()
	count_enemies()


func count_enemies():
	enemy_count = $Robots.get_child_count()


func instance_PC():
	var Player
	if customisation.Player_character == "Male":
		Player = customisation.male.instance()
	else:
		Player = customisation.female.instance()
	
	add_child(Player)
	Player.transform = $PlayerStartPosition.transform


func remove_enemy():
	enemy_count -= 1
	if enemy_count < 1:
		get_tree().change_scene("res://Scenes/GUI/Victory/Victory.tscn")