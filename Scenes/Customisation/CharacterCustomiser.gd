extends Spatial

var current_material = 1
var gender


func _ready():
	get_tree().paused = false
	$ArmatureM/AnimationPlayer.play("Idle")
	$ArmatureF/AnimationPlayer.play("Idle")
	gender = "Male"
	$ArmatureF.hide()


func change_material(direction):
	var materials_count = $MaterialsList.materials.size()
	

	if direction == "Right":
		if current_material == materials_count: #check if we're at the last material
			current_material = 1
		else:
			current_material += 1
	else: 
		if current_material == 1: # check if we're at the first material
			current_material = materials_count
		else:
			current_material -= 1
	
	var PlayerM = $ArmatureM/Mesh
	var PlayerF = $ArmatureF/Mesh
	
	PlayerM.set_surface_material(0, load($MaterialsList.materials[current_material]))
	PlayerF.set_surface_material(0, load($MaterialsList.materials[current_material]))


func _on_ButtonBegin_pressed():
	Customisations.Player_materials = $MaterialsList.materials[current_material]
	Customisations.Player_gender = gender
	get_tree().change_scene("res://Scenes/Game.tscn")


func Character_selection(ID):
	$ArmatureM.hide()
	$ArmatureF.hide()
	
	match ID:
		0:
			gender = "Male"
			$ArmatureM.show()
		1:
			gender = "Female"
			$ArmatureF.show()

