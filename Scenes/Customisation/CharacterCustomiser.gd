extends Spatial

var current_material = 1


func _ready():
	pass


func materials_ready():
	pass


func change_material(direction):
	var materials_count = $MaterialsList.materials.size()
	
	#check if we can go up
	if direction == "Right":
		if current_material == materials_count:
			current_material = 1
		else:
			current_material += 1
	else:
		if current_material == 1:
			current_material = materials_count
		else:
			current_material -= 1
	
	var Player = $PlayerModelM/Armature/Human_Mesh
	
	Player.set_surface_material(0, load($MaterialsList.materials[current_material]))


func _on_ButtonBegin_pressed():
	Customisations.Player_materials = $MaterialsList.materials[current_material]
	get_tree().change_scene("res://Scenes/Characters/Game.tscn")
