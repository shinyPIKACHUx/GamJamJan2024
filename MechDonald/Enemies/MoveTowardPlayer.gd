class_name MoveTowardPlayer extends CharacterBody3D

#Min speed of the mob m/s
@export var min_speed = 10

#Min speed of the mob m/s
@export var max_speed = 18

var player_position
var target_position
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide()

# Called from the main scene
func initialize(start_position, player_position):
	# Place mob at start position and rotate toward player
	look_at_from_position(start_position, player_position, Vector3.UP)
	
	# Rotate slightly so that it doesn't move DIRECTLY toward player
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	# Calculates a random speed
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	
	# Rotate velocity based on mob's rotation to move in looking direction
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
func _on_visible_on_screen_enabler_3d_screen_exited():
	queue_free();
