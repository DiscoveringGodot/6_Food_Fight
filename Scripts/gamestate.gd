extends Spatial

var enemy_count


func _ready():
	enemy_count = $Robots.get_child_count()

func remove_enemy():
	enemy_count -= 1
	if enemy_count < 1:
		get_tree().change_scene("res://Scenes/GUI/Victory/Victory.tscn")