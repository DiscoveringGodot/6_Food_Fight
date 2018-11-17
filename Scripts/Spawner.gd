extends Spatial

export var bystander_speed = 10
export var max_wait_time = 5

var bystanders = {}

func _enter_tree():
	bystanders = file_grabber.get_files("res://Scenes/Bystanders/")
	randomize()
	set_timer()


func set_timer():
	$Timer.wait_time = randi() % max_wait_time + 1
	$Timer.start()

func _on_Timer_timeout():
	spawn_bystander()
	set_timer()


func spawn_bystander():
	var bystander = load(bystanders[randi() % bystanders.size()]).instance()
	add_child(bystander)
	bystander.set_as_toplevel(true)
	bystander.set_transform($Forward.get_global_transform())
	bystander.set_linear_velocity($Forward.get_global_transform().basis[2].normalized() * bystander_speed)
	
	
	
	