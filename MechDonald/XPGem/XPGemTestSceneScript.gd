extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var p = get_tree().get_first_node_in_group("Player")
	var gem = XPGemFactory.create(100, p.get_path())
	gem.global_position = Vector3(0, 3, -10)
	get_tree().root.add_child.call_deferred(gem)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
