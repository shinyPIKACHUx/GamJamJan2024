extends Area3D

@onready var mesh = $MeshInstance3D
@onready var particles = $GPUParticles3D

@export var targetGroup : String
@export var SPEED = 20.0

func _physics_process(delta):
	global_position += transform.basis * Vector3(0, 0, -SPEED) * delta

func _on_timer_timeout():
	queue_free()

func _on_body_entered(body):
	mesh.visible = false
	particles.emitting = true
	if body.is_in_group(targetGroup):
		body.hit()
	queue_free()
