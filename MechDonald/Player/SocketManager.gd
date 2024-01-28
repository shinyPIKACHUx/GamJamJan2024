extends Node3D

@onready var armRight : Node3D = $ArmRight
@onready var armLeft : Node3D = $ArmLeft
@onready var legRight : Node3D = $LegRight
@onready var legLeft : Node3D = $LegLeft
@onready var head : Node3D = $Head

@export var sockets : Array[Node3D] = [armRight, armLeft, legRight, legLeft, head]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_Socket_Types():
	return [armRight.get_animal(), armLeft.get_animal(), legRight.get_animal(), legLeft.get_animal(), head.get_animal()]

func set_socket_arm_right(name:Socket.Animal):
	armRight.set_animal(name)

func set_socket_arm_left(name:Socket.Animal):
	armLeft.set_animal(name)

func set_socket_leg_right(name:Socket.Animal):
	legRight.set_animal(name)

func set_socket_leg_left(name:Socket.Animal):
	legLeft.set_animal(name)

func set_socket_head(name:Socket.Animal):
	head.set_animal(name)

