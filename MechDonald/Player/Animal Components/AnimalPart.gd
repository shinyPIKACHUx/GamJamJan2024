extends Node3D

@export var bullet : PackedScene
@export var FireRateTimer : float = 1.0

@onready var rayCast : RayCast3D = $RayCast3D
@onready var timer : Timer = $Timer

var fireDuration: float = 0.0

var bulletInstance
var canFire : bool = true

func _ready():
	timer.wait_time = FireRateTimer

func _physics_process(delta):
	print("checking firing bullets")
	self.fireDuration += delta
	if (self.fireDuration >= self.FireRateTimer):
		print("firing bullets")
		bulletInstance = bullet.instantiate()
		bulletInstance.position = rayCast.global_position
		bulletInstance.transform.basis = rayCast.global_transform.basis
		get_parent().add_child(bulletInstance)

func _on_timer_timeout():
	canFire = true
