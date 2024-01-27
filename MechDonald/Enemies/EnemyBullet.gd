extends Area3D


func _physics_process(delta):
	move_and_collide(velocity * delta)

func initialize(pos, vel):
	position = pos
	velocity = vel


func _on_timer_timeout():
	queue_free()
