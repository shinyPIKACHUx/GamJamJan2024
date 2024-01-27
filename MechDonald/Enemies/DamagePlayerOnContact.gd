extends CollisionShape3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_collision(body):
	if body.is_in_group("Player"):
		print("Damage player")

