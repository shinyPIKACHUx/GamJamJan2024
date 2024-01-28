extends Node

@export var AnimalScene: PackedScene

var playerRef

# Called when the node enters the scene tree for the first time.
func _ready():
	playerRef = get_tree().get_first_node_in_group("Player")
	apply_upgrade()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_upgrade():

	playerRef.fart_tick_speed = playerRef.fart_tick_speed / 2
	
