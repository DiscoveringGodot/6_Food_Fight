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
	
	print("Material " + str(current_material) + " of " + str(materials_count))
	
	var Player = $PlayerModelM/Armature/Human_Mesh
	
	Player.set_surface_material(0, load($MaterialsList.materials[current_material]))
