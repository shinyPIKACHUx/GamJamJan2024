class_name BossEnemy extends CharacterBody3D

#speed of the mob m/s
@export var speed = 2
@export var chargeSpeed = 5
@export var hp = 50

var playerRef
enum BEHAVIOR_STATE {MOVE_CLOSER, TELEGRAPH, CHARGE}
var currentBehavior
var chargeDirection


# Called when the node enters the scene tree for the first time.
func _ready():
	playerRef = get_tree().get_first_node_in_group("Player")
	currentBehavior = BEHAVIOR_STATE.MOVE_CLOSER
	playerRef = get_tree().get_first_node_in_group("Player")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Rotate toward player

	match currentBehavior:
		BEHAVIOR_STATE.MOVE_CLOSER:
			look_at(playerRef.position, Vector3.UP)
			position = position.move_toward(playerRef.position, delta * speed)
		BEHAVIOR_STATE.TELEGRAPH:
			look_at(playerRef.position, Vector3.UP)
		BEHAVIOR_STATE.CHARGE:
			position = position.move_toward(position + chargeDirection, delta * chargeSpeed)

# Called from the main scene
func initialize(spawn_location):
	# Set position data
	position = spawn_location

func move_closer():
	currentBehavior = BEHAVIOR_STATE.MOVE_CLOSER
	$MoveTimer.start(5.0)

func telegraph():
	currentBehavior = BEHAVIOR_STATE.TELEGRAPH
	$TelegraphTimer.start(0.5)

func charge():
	currentBehavior = BEHAVIOR_STATE.CHARGE
	chargeDirection = position.direction_to(playerRef.position)
	$ChargeTimer.start(1.0)
	
func take_damage(damage):
	hp -= damage
	if hp <= 0:
		var xpgem = XPGemFactory.create(100, "../Target")
		get_tree().add_child(xpgem)
		queue_free()
		
func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		playerRef.take_damage(15)

func _on_visible_on_screen_enabler_3d_screen_exited():
	queue_free();
