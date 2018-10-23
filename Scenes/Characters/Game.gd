extends Node

var ammo_types = [preload("res://Scenes/Ammo/Burger.tscn"), 
		preload("res://Scenes/Ammo/Doughnut.tscn"), 
		preload("res://Scenes/Ammo/Soda.tscn"), 
		preload("res://Scenes/Ammo/Hotdog.tscn"), 
		preload("res://Scenes/Ammo/IceCream.tscn")]

var score = {1:0, 2:0}
var lives = {1:3, 2:3}

func update_score(player, add_to_score):
	if add_to_score:
		score[player]+=1
	elif player == 1 :
			score[player]-=1
	get_tree().call_group("GUI", "update_score", score)

