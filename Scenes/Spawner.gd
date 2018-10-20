extends Spatial

export var speed = 10
var max_wait = 5

var bystanders = {}

func _ready():
	bystanders = get_node("../../Bystanders").bystanders
	set_timer()

func set_timer():
	randomize()
	$Timer.wait_time = randi() % max_wait +1
	$Timer.start()


func _on_Timer_timeout():
	call_deferred("spawn")
	set_timer()

func spawn():
	randomize()
	var bullet = load(bystanders[randi() % bystanders.size() +1]).instance()
	bullet.set_transform(get_node("Forward").get_global_transform().orthonormalized())
	bullet.set_linear_velocity(get_node("Forward").get_global_transform().basis[2].normalized()*speed)
	get_parent().add_child(bullet)
	
	