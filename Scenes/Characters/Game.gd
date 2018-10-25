extends Node

var enemy_count


func _ready():
	customise_player()
	count_enemies()


func customise_player():
	var Player
	if Customisations.Player_gender == "Male":
		Player = Customisations.male.instance()
	else:
		Player = Customisations.female.instance()

	add_child(Player)
	Player.transform = $PlayerSpawn.transform


func count_enemies():
	enemy_count = $Enemies.get_child_count()


func remove_enemy():
	enemy_count -= 1
	if enemy_count < 1:
		get_tree().change_scene("res://Scenes/Victory/Victory.tscn")