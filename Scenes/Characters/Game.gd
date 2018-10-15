extends Spatial

var ammo_types = [load("res://Scenes/Ammo/Burger.tscn"), 
		load("res://Scenes/Ammo/Doughnut.tscn"), 
		load("res://Scenes/Ammo/Soda.tscn"), 
		load("res://Scenes/Ammo/Hotdog.tscn"), 
		load("res://Scenes/Ammo/IceCream.tscn")]

var score = {1:0, 2:0}

func update_score(player, add_to_score):
	if add_to_score:
		score[player]+=1
	else:
		score[player]-=1
	get_tree().call_group("GUI", "update_score", score)