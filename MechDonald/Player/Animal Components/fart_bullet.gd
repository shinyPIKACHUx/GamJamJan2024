extends Area3D


@onready var mesh = $MeshInstance3D
@onready var particles = $GPUParticles3D
@onready var timer = $Timer

@export var targetGroup : String
@export var splitTimer : float = 2.0
@export var splitCount : int = 1
@export var splitAngle : float = 45.0
@export var SPEED = 20.0

func _ready():
	timer.wait_time = splitTimer

func _physics_process(delta):
	global_position += transform.basis * Vector3(0, 0, -SPEED) * delta

func _on_timer_timeout():
	if splitCount > 0:
		var newSplitCount = splitCount - 1
		var heading = global_transform.basis
		var heading1 = heading.rotate_x(deg_to_rad(splitAngle)) + heading.rotate_y(deg_to_rad(splitAngle))
		var heading2 = heading.rotate_x(deg_to_rad(-splitAngle)) + heading.rotate_y(deg_to_rad(splitAngle))
		var heading3 = heading.rotate_x(deg_to_rad(splitAngle)) + heading.rotate_y(deg_to_rad(-splitAngle))
		var heading4 = heading.rotate_x(deg_to_rad(-splitAngle)) + heading.rotate_y(deg_to_rad(-splitAngle))
		
		var instance1 = (load("res://Player/Fart_bullet.tscn") as PackedScene).instantiate()
		instance1.position = global_position
		instance1.transform.basis = heading1
		instance1.splitCount = newSplitCount
		var instance2 = (load("res://Player/Fart_bullet.tscn") as PackedScene).instantiate()
		instance2.position = global_position
		instance2.transform.basis = heading2
		instance2.splitCount = newSplitCount
		var instance3 = (load("res://Player/Fart_bullet.tscn") as PackedScene).instantiate()
		instance3.position = global_position
		instance3.transform.basis = heading3
		instance3.splitCount = newSplitCount
		var instance4 = (load("res://Player/Fart_bullet.tscn") as PackedScene).instantiate()
		instance4.position = global_position
		instance4.transform.basis = heading4
		instance4.splitCount = newSplitCount
		
		get_parent().add_child(instance1)
		get_parent().add_child(instance2)
		get_parent().add_child(instance3)
		get_parent().add_child(instance4)
	queue_free()

func _on_body_entered(body):
	mesh.visible = false
	particles.emitting = true
	if body.is_in_group(targetGroup):
		body.hit()
	queue_free()
