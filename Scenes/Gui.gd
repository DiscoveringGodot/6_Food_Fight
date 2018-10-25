extends CanvasLayer

func update_gui(ammo):
	$AmmoCount.text = str(ammo)

func refill(amount):
	$refill.value = amount * 100

func empty_GUI():
	$refill.value = 0
	

func update_lives(lives):
	var heart = preload("res://gfx/heart.png")
	$Lives.clear()
	for i in lives:
		$Lives.add_icon_item(heart, false)