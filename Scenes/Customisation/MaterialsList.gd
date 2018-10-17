extends Node

var materials = {}

signal ready

func _enter_tree():
	connect("ready", get_parent(), "materials_ready")
	get_materials()
	emit_signal("ready")


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