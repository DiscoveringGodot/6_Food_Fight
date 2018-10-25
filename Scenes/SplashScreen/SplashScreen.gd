extends Control



func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Customisation/CharacterCustomiser.tscn")


func _on_Button2_pressed():
	get_tree().quit()
