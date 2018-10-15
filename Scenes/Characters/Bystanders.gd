extends Node

var bystanders = {}

func _ready():
	get_bystanders()

func get_bystanders():
	var bystander_count = 1
	var dir = Directory.new()
	var path = "res://Scenes/Bystanders/"
	dir.open(path)
	dir.list_dir_begin()

	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			bystanders[bystander_count] = (path+file)
			bystander_count += 1