extends Node3D

@export var bullet : PackedScene
@export var FireRateTimer : float = 1.0

@onready var rayCast : RayCast3D = $RayCast3D
@onready var timer : Timer = $Timer

var bulletInstance
var canFire : bool = true

func _ready():
	timer.wait_time = FireRateTimer

func _physics_process(delta):
	if rayCast.is_colliding():
		var object = rayCast.get_collider()
		if object.is_in_group("Enemy"):
			fire_bullets()

func fire_bullets():
	if canFire:
		bulletInstance = bullet.instantiate()
		bulletInstance.position = global_position
		bulletInstance.transform.basis = global_transform.basis
		get_parent().add_child(bulletInstance)
		canFire = false


func _on_timer_timeout():
	canFire = true
