extends Node

var materials = {}


func _enter_tree():
	materials = file_grabber.get_files("res://Scenes/Customisation/PlayerMaterials/")
