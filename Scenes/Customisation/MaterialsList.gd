extends Node

var materials = {}


func _enter_tree():
	get_materials()


func get_materials():
	var materials_count = 1
	var dir = Directory.new()
	var path = "res://Scenes/Customisation/PlayerMaterials/"
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			materials[materials_count] = (path+file)
			materials_count += 1