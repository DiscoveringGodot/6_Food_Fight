extends Spatial

export var speed = 10
var max_wait = 5

var bystanders = {}

func _enter_tree():
	bystanders = file_grabber.get_files("res://Scenes/Bystanders/")
	set_timer()
	randomize()

func set_timer():
	$Timer.wait_time = randi() % max_wait +1
	$Timer.start()


func _on_Timer_timeout():
	call_deferred("spawn")
	set_timer()

func spawn():
	var bullet = load(bystanders[randi() % bystanders.size() ]).instance()
	add_child(bullet)
	bullet.set_as_toplevel(true)
	bullet.set_transform(get_node("Forward").get_global_transform().orthonormalized())
	bullet.set_linear_velocity(get_node("Forward").get_global_transform().basis[2].normalized()*speed)
	
	