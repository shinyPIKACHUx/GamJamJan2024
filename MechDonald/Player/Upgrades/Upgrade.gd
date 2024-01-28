extends Node

@export var AnimalScene: PackedScene
@export var UpgradeType = "EggGun" #or GasCloud


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_upgrade():
	
	print("wahoo")
