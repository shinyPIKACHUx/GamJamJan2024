extends Node3D
class_name Socket
enum Animal{
	Blank,
	Chicken,
	Cow,
	Duck,
	Pig,
	Sheep
}

@export var animal : Animal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_animal():
	return animal

func set_animal(name):
	animal = name
