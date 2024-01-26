class_name ShootingEnemy extends CharacterBody3D

#speed of the mob m/s
@export var speed = 2

var playerRef
var runAwayDist = 6
var moveCloserDist = 8
enum BEHAVIOR_STATE {MOVE_CLOSER, RUN_AWAY, SHOOT}
var currentBehavior

# Called when the node enters the scene tree for the first time.
func _ready():
	currentBehavior = BEHAVIOR_STATE.MOVE_CLOSER
	pass # Replace with function body.


func _process(delta):
	var distToPlayer = position.distance_to(playerRef.position)
	if (distToPlayer > moveCloserDist):
		currentBehavior = BEHAVIOR_STATE.MOVE_CLOSER
	elif (distToPlayer < runAwayDist):
		currentBehavior = BEHAVIOR_STATE.RUN_AWAY
	else:
		currentBehavior = BEHAVIOR_STATE.SHOOT
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Rotate toward player
	look_at(playerRef.position, Vector3.UP)

	match currentBehavior:
		BEHAVIOR_STATE.MOVE_CLOSER:
			position = position.move_toward(playerRef.position, delta * speed)
		BEHAVIOR_STATE.RUN_AWAY:
			position = position.move_toward(playerRef.position, delta * -speed)
		BEHAVIOR_STATE.SHOOT:
			print("Shoot!")

# Called from the main scene
func initialize(spawn_location, player):
	# Set player reference
	playerRef = player
	
	# Set position data
	position = spawn_location
	
func _on_visible_on_screen_enabler_3d_screen_exited():
	queue_free();
