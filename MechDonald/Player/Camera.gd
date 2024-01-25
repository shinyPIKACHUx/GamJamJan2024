extends Camera3D

@onready var cameraPivotNode : Node3D = $"../CameraPivot"
@onready var cameraVisionTargetNode : Node3D = $"../CameraPivot/CameraVisonTarget"
@onready var cameraMoveTargetNode : Node3D = $"../CameraPivot/SpringArm3D/CameraMoveTarget"
@onready var label : Label = $Label

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
	gp_current = cameraMoveTargetNode.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if update:
		update_position()
		update = false
	
	var f = clamp(Engine.get_physics_interpolation_fraction(), 0, 1)
	global_position = gp_previous.lerp(gp_current, f)
	
	look_at(cameraVisionTargetNode.global_position)
	label.set_text("camera pivot rotation = %s" % cameraPivotNode.rotation)

func _physics_process(_delta):
	update = true
