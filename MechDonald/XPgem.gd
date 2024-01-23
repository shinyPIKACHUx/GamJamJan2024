extends Node3D

# if beyond the slowlyApproachPlayerThreshold, teleport to the teleport distance
@export var teleportToDistance: float # when teleported, gem will appear along its dir vector to player at this distance
@export var slowlyApproachPlayerThreshold: float # if gem is closer than this distance, slowly approach the player
@export var finalAttractToPlayerThreshold: float # if gem is closer than this distance, quickly approach player so it is acquired
@export var playerNodeName: String = "Player"

@onready var XPGem: Area3D = $XPGem as Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#find player and move towards it depending on distance to player
	var playerPos: Vector3 = get_tree().get_node(playerNodeName).global_position
	var vectorToPlayer: Vector3 = playerPos - XPGem.global_position
	var dirVecToPlayer: Vector3 = VectorToPlayer.normalized()
	var distToPlayer: float = sqrt(VectorToPlayer.dot(VectorToPlayer))
	
	if (distToPlayer <= slowlyApproachPlayerThreshold):
		pass #placeholder // slowly approach
	else if (distToPlayer <= finalAttractToPlayerThreshold):
		pass #placeholder // quickly approach
	else: # teleport (preferablly 
		var 
	
	
	pass



