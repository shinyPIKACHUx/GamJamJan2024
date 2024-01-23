extends Camera3D

@onready var PlayerNode : Node3D = $".."
@onready var cameraVisionTargetNode : Node3D = $"../CameraVisonTarget"
@onready var cameraPivot : Node3D = $"../CameraPivot"
@onready var cameraMoveTargetNode : Node3D = $"../CameraPivot/SpringArm3D/CameraMoveTarget"

@export var lerp_speed : float = 0.5
@export var lerp_scale : float = 0.1

var lerp_target
var lerp_result : Vector3
var cameraMoveTarget : Vector3

var update = false
var gp_previous : Vector3
var gp_current : Vector3

func _ready():
	set_as_top_level(true)
	cameraMoveTarget = cameraMoveTargetNode.global_position
	global_position = cameraMoveTarget
	
	gp_previous = cameraMoveTarget
	gp_current = cameraMoveTarget

func update_position():
	gp_previous = gp_current
	gp_current = cameraMoveTarget

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if update:
		update_position()
		update = false
	
	var f = clamp(Engine.get_physics_interpolation_fraction(), 0, 1)
	global_position = gp_previous.lerp(gp_current, f)
	
	#cameraMoveTarget = cameraMoveTargetNode.global_position
	#lerp_target = lerp(global_position, cameraMoveTarget, lerp_scale)
	#
	#lerp_result = lerp(global_position, lerp_target, lerp_speed * delta)
	#
	#global_position.x = lerp_result.x
	#global_position.z = lerp_result.z
	#global_position.y = lerp_result.y
	look_at(cameraVisionTargetNode.global_position)


func _physics_process(delta):
	update = true
