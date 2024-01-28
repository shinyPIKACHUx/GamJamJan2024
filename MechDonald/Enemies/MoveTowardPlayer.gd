class_name MoveTowardPlayer extends CharacterBody3D

#speed of the mob m/s
@export var speed = 2
@export var hp = 15

var playerRef

# Called when the node enters the scene tree for the first time.
func _ready():
	playerRef = get_tree().get_first_node_in_group("Player")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Rotate toward player
	look_at(playerRef.position, Vector3.UP)

	# Move toward player
	position = position.move_toward(playerRef.position, delta * speed)

# Called from the main scene
func initialize(spawn_location):
	# Set position data
	position = spawn_location
	
func take_damage(damage):
	hp -= damage
	if hp <= 0:
		var xpgem = XPGemFactory.create(100, "../Target")
		get_tree().add_child(xpgem)
		queue_free()

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		playerRef.take_damage(5)
	
func _on_visible_on_screen_enabler_3d_screen_exited():
	queue_free();
