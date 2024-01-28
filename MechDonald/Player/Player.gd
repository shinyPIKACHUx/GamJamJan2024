extends CharacterBody3D

const MAX_CAMERA_ANGLE = 70#89
const MIN_CAMERA_ANGLE = -60#-89

const ACCEL_DEFAULT = 7# 10
const GRAVITY_BASE = 9.8
const WALK_SPEED = 5.0
const MOUSE_SENSITIVITY_BASE = 0.01 # 0.08, 0.03, 0.1

@export var speed : float = WALK_SPEED 
@export var acceleration : float = ACCEL_DEFAULT
@export var mouse_sensitivity : float = MOUSE_SENSITIVITY_BASE
@export var gravity = GRAVITY_BASE

@onready var cameraPivot = $CameraPivot
@onready var visionTarget = $CameraVisonTarget

@onready var bullet = "res://Player/generic_bullet.tscn"

@export var healthMax : float = 100.0
var healthCurrent : float = healthMax
var totalXP: float = 0.0

var invuln: float = 3.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	#get mouse input for camera rotation
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		cameraPivot.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		cameraPivot.rotation.x = clamp(cameraPivot.rotation.x, deg_to_rad(MIN_CAMERA_ANGLE), deg_to_rad(MAX_CAMERA_ANGLE))

func _process(delta):
	print_debug("currentXP: " + str(self.totalXP).pad_decimals(2))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# get keyboard input
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# for movement that has momentum
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration * delta)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, acceleration * delta)
		velocity.z = lerp(velocity.z, 0.0, acceleration * delta)
	
	move_and_slide()


func addXP(xp: float):
	self.totalXP += xp

func take_damage():
	print("Ouch!")

