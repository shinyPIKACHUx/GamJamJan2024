class_name MoveTowardPlayer extends CharacterBody3D

#speed of the mob m/s
@export var speed = 2

var playerRef

# Called when the node enters the scene tree for the first time.
func _ready():
	print("I exist!")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Rotate toward player
	look_at(playerRef.position, Vector3.UP)
	#rotate_z(position.angle_to(playerRef.position))
	#velocity = global_transform.origin.direction_to(playerRef.global_transform.origin).normalized()
	#velocity *= delta * speed
	
	# Rotate velocity based on mob's rotation to move in looking direction
	#set_velocity(velocity.rotated(Vector3.UP, rotation.y))
	
	#move_and_collide(velocity * delta * speed)
	position = position.move_toward(playerRef.position, delta * speed)

# Called from the main scene
func initialize(spawn_location, player):
	playerRef = player
	
	position = spawn_location
	
	## Rotate toward player
	#look_at_from_position(spawn_location, player.global_transform.origin, Vector3.UP)
	#velocity = Vector3.MODEL_FRONT * speed
	#
	## Rotate velocity based on mob's rotation to move in looking direction
	##set_velocity(velocity.rotated(Vector3.UP, rotation.y))
	#set_velocity(velocity)
	
func _on_visible_on_screen_enabler_3d_screen_exited():
	queue_free();
