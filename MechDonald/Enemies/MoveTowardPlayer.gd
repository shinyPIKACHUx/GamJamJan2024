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

	# Move toward player
	position = position.move_toward(playerRef.position, delta * speed)

# Called from the main scene
func initialize(spawn_location, player):
	# Set player reference
	playerRef = player
	
	# Set position data
	position = spawn_location
	
func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		playerRef.take_damage()
	
func _on_visible_on_screen_enabler_3d_screen_exited():
	queue_free();
