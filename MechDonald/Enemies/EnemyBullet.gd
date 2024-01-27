extends CharacterBody3D

var playerRef

func _physics_process(delta):
	move_and_collide(velocity * delta)

func initialize(player, pos, vel):
	playerRef = player
	position = pos
	velocity = vel


func _on_timer_timeout():
	queue_free()


func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		playerRef.take_damage()

