extends CanvasLayer

func update_gui(ammo):
	$AmmoCount.text = str(ammo)

func refill(amount):
	$refill.value = amount * 100

func empty_GUI():
	$refill.value = 0
	

func update_score(score):
	$ScoreContainer/Score1.text = str(score[1])
	$ScoreContainer/Score2.text = str(score[2])


func update_lives(lives):
	if $PlayerLives.get_child_count() > 0:
		var child = $PlayerLives.get_child(0)
		child.queue_free()

	if $PlayerLives.get_child_count() < 1:
		get_tree().quit()
