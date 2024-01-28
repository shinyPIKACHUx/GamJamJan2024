extends "Upgrade.gd"

var playerRef

# Called when the node enters the scene tree for the first time.
func _ready():
	playerRef = get_tree().get_first_node_in_group("Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func apply_upgrade():
	playerRef.fart_duration = playerRef.fart_duration * 1.5
	
