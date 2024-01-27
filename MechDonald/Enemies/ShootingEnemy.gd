class_name ShootingEnemy extends Area3D

#speed of the mob m/s
@export var speed = 2
@export var shotSpeed = 5
@export var bullet_scene: PackedScene
@export var runAwayDist = 6
@export var moveCloserDist = 8

var playerRef
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
			position = position

# Called from the main scene
func initialize(spawn_location, player):
	# Set player reference
	playerRef = player
	
	# Set position data
	position = spawn_location

func shoot():
	if (currentBehavior == BEHAVIOR_STATE.SHOOT):
		print("SHOOT")
		var bullet = bullet_scene.instantiate()
	
		var bullet_spawn_location = get_node("BulletSpawnLocation")
		var direction = bullet_spawn_location.global_position.direction_to(playerRef.global_position)
		
		get_tree().current_scene.add_child(bullet)
		bullet.initialize(bullet_spawn_location.global_position, direction * shotSpeed)
	
func _on_visible_on_screen_enabler_3d_screen_exited():
	queue_free();
