extends Node3D

enum Animals{
	Blank,
	Chicken,
	Cow,
	Duck,
	Pig,
	Sheep
}
@export var animal : Animals

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = get_children()
	for child in children:
		child.set_visible(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
