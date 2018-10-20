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