extends Area




func _on_Area_body_entered(body):
	if body.has_method("Refil_entered"):
		body.Refil_entered()


func _on_Area_body_exited(body):
	if body.has_method("Refil_exited"):
		body.Refil_exited()

