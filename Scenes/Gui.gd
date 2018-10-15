extends CanvasLayer

func update_gui(ammo):
	$AmmoCount.text = str(ammo)

func refill(amount):
	$refil.value = amount * 100
	

func update_score(score):
	$ScoreContainer/Score1.text = str(score[1])
	$ScoreContainer/Score2.text = str(score[2])