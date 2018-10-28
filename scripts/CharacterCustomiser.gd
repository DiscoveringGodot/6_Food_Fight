extends Spatial

var current_material = 0
var player_character # To do enum and switch to character


func _ready():
	get_tree().paused = false # possible to enter the scene in paused state if we don't
	$ArmatureM/AnimationPlayer.play("Idle")
	$ArmatureF/AnimationPlayer.play("Idle")
	player_character = "Male"
	$ArmatureF.hide()


func change_material(direction):
	var materials_count = $MaterialsList.materials.size() -1

	next_material(materials_count, direction)

	var PlayerM = $ArmatureM/Mesh
	var PlayerF = $ArmatureF/Mesh

	PlayerM.set_surface_material(0, load($MaterialsList.materials[current_material]))
	PlayerF.set_surface_material(0, load($MaterialsList.materials[current_material]))

func next_material(materials_count, direction):
	if direction == "Right": 
		if current_material == materials_count: #check if we're at the last material
			current_material = 0
		else:
			current_material += 1
	else: 
		if current_material == 0: # check if we're at the first material
			current_material = materials_count
		else:
			current_material -= 1


func _on_ButtonBegin_pressed():
	Customisations.Player_materials = $MaterialsList.materials[current_material]
	Customisations.Player_character = player_character
	get_tree().change_scene("res://Scenes/Game.tscn")


func Character_selection(ID):
	$ArmatureM.hide()
	$ArmatureF.hide()
	
	match ID:
		0:
			player_character = "Male"
			$ArmatureM.show()
		1:
			player_character = "Female"
			$ArmatureF.show()

