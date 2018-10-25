extends Node

var ammo_types = [preload("res://Scenes/Ammo/Burger.tscn"), 
		preload("res://Scenes/Ammo/Doughnut.tscn"), 
		preload("res://Scenes/Ammo/Soda.tscn"), 
		preload("res://Scenes/Ammo/Hotdog.tscn"), 
		preload("res://Scenes/Ammo/IceCream.tscn")]

var male = preload("res://Scenes/Characters/Players/Player-M.tscn").instance()
var female = preload("res://Scenes/Characters/Players/Player-F.tscn").instance()

var score = {1:0, 2:0}
var lives = {1:3, 2:3}


func _ready():
	var Player
	print(Customisations.Player_gender)
	if Customisations.Player_gender == "Male":
		Player = male
	else:
		Player = female
	
	add_child(Player)
	Player.transform = $PlayerSpawn.transform



