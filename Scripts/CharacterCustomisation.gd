extends Spatial

var materials_list = {}
var current_material = 0
var current_player
var selected_material # the material we're passing through to customisation.gd

func _ready():
	get_tree().paused = false
	materials_list = file_grabber.get_files("res://Scenes/Customisation/PlayerMaterials/")
	current_player = "Female"
	print(materials_list)
	$ArmatureM.hide()

func _on_CharacterSelect_item_selected(ID):
	$ArmatureF.hide()
	$ArmatureM.hide()
	
	match ID:
		0:
			current_player = "Female"
			$ArmatureF.show()
		1:
			current_player = "Male"
			$ArmatureM.show()


func change_material(direction):
	var materials_count = materials_list.size() -1
	
	select_material(direction, materials_count)
	
	var Male = $ArmatureM/Mesh
	var Female = $ArmatureF/Mesh
	
	selected_material = load(materials_list[current_material])
	
	Male.set_surface_material(0, selected_material)
	Female.set_surface_material(0, selected_material)


func select_material(direction, materials_count):
	if direction == "Right":
		if current_material == materials_count:
			current_material = 0
		else:
			current_material += 1
	else:
		if current_material == 0:
			current_material = materials_count
		else:
			current_material -= 1
	
	print (current_material)


func _on_StartButton_pressed():
	customisation.Player_materials = selected_material
	customisation.Player_character = current_player
	get_tree().change_scene("res://Scenes/Levels/Level1.tscn")
