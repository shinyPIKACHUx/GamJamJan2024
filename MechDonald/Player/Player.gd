extends CharacterBody3D

# const SPEED = 5.0
# const JUMP_VELOCITY = 4.5
# var project_gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

const MAX_CAMERA_ANGLE = 70#89
const MIN_CAMERA_ANGLE = -60#-89

const ACCEL_DEFAULT = 7# 10
#const ACCEL_AIR = 1
const GRAVITY_BASE = 9.8
const WALK_SPEED = 5.0
#const SPRINT_SPEED = 8.0# 7, 10, 15
#const JUMP_VELOCITY_BASE = 4.5 # 5, 10
const MOUSE_SENSITIVITY_BASE = 0.01 # 0.08, 0.03, 0.1

# cameraPivot bob vars
#const BOB_FREQ = 2.0
#const BOB_AMP = 0.08
#var t_bob = 0.0

#fov Vars
#const BASE_FOV = 75.0
#const FOV_CHANGE = 1.5

@export var speed : float = WALK_SPEED 
@export var acceleration : float = ACCEL_DEFAULT
@export var mouse_sensitivity : float = MOUSE_SENSITIVITY_BASE
#@export var jump_impulse = JUMP_VELOCITY_BASE
#@export var jump_total = 2.0 
@export var gravity = GRAVITY_BASE

#var jump_count = 0
#var full_contact = false
#var cam_accel = 40

#var gravity_direction = Vector3()
#var movement = Vector3()

@onready var cameraPivot = $CameraPivot
@onready var visionTarget = $CameraVisonTarget
#@onready var camera = $Camera3D
#@onready var ground_check = $GroundCheck

var totalXP: float = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$CameraPivot/SpringArm3D.add_excluded_object(self)

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	#get mouse input for camera rotation
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		cameraPivot.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		cameraPivot.rotation.x = clamp(cameraPivot.rotation.x, deg_to_rad(MIN_CAMERA_ANGLE), deg_to_rad(MAX_CAMERA_ANGLE))
		#visionTarget.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		#visionTarget.rotation.x = clamp(visionTarget.rotation.x, deg_to_rad(MIN_CAMERA_ANGLE), deg_to_rad(MAX_CAMERA_ANGLE))

func _process(delta):
	print_debug("currentXP: " + str(self.totalXP).pad_decimals(2))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# get keyboard input
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	#var input_dir = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# for movement that has momentum
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration * delta)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, acceleration * delta)
		velocity.z = lerp(velocity.z, 0.0, acceleration * delta)
	
	#if direction:
		#velocity.x = direction.x * speed
		#velocity.z = direction.z * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
		#velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()

# Alternate, movement code for full Third person Controller
#func _physics_process(delta):
# Add the gravity.
	#if not is_on_floor():
		#velocity.y -= gravity * delta
		#acceleration = ACCEL_AIR
	#else:
		#acceleration = ACCEL_DEFAULT
	
	# get keyboard input
	#var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	#var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# handle Sprint
	#if Input.is_action_pressed("sprint"):
		#speed = SPRINT_SPEED
	#else:
		#speed = WALK_SPEED
	#
	# Handle jumping.
	#if Input.is_action_just_pressed("jump") and (is_on_floor() or ground_check.is_colliding() or jump_count < jump_total):
		#jump_count += 1
		#velocity.y = jump_impulse
	
	
	# cameraPivotbob
	#t_bob += delta * velocity.length() * float(is_on_floor())
	#cameraPivot.transform.origin = _cameraPivotbob(t_bob)
	
	# FOV change on sprint
	#var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	#var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	#camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	# for movement that has momentum
	#if direction:
		#velocity.x = lerp(velocity.x, direction.x * speed, acceleration * delta)
		#velocity.z = lerp(velocity.z, direction.z * speed, acceleration * delta)
	#else:
		#velocity.x = lerp(velocity.x, 0.0, acceleration * delta)
		#velocity.z = lerp(velocity.z, 0.0, acceleration * delta)
	
	# for extremely responsive movement
	#if direction:
		#velocity.x = direction.x * speed
		#velocity.z = direction.z * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
		#velocity.z = move_toward(velocity.z, 0, speed)
	#
	#move_and_slide()

func addXP(xp: float):
	self.totalXP += xp

func getXP():
	return self.totalXP
#func _cameraPivotbob(time) -> Vector3:
	#var pos = Vector3.ZERO
	#pos.y = sin(time * BOB_FREQ) * BOB_AMP
	#return pos
