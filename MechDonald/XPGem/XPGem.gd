extends Area3D

@export var xp: float # amount of xp this gem is worth
# if beyond the slowlyApproachPlayerThreshold, teleport to the teleport distance
@export var teleportToDistance: float # when teleported, gem will appear along its dir vector to player at this distance
@export var slowlyApproachTargetThreshold: float # if gem is closer than this distance, slowly approach the player
@export var finalAttractToTargetThreshold: float # if gem is closer than this distance, quickly approach player so it is acquired
@export var targetNodePath: NodePath
@export var slowlyApproachRate: float = 1.0
@export var finalAttractDeltaLerpMultiplier: float = 0.4

var targetNode: CharacterBody3D = null
var lerpDeltaAccumulator: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.targetNode = get_node(targetNodePath)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#find player and move towards it depending on distance to player
	if (self.targetNode):
		var targetPos: Vector3 = self.targetNode.global_position
		var vectorToTarget: Vector3 = targetPos - self.global_position
		var dirVecToTarget: Vector3 = vectorToTarget.normalized()
		var distToTarget: float = sqrt(vectorToTarget.dot(vectorToTarget))
		
		if (distToTarget <= finalAttractToTargetThreshold):
			lerpDeltaAccumulator += delta * finalAttractDeltaLerpMultiplier
			self.global_position = self.global_position.lerp(targetPos, lerpDeltaAccumulator)
		elif (distToTarget <= slowlyApproachTargetThreshold):
			self.global_position = self.global_position.move_toward(targetPos, slowlyApproachRate)
		else:	# teleport (preferablly offscreen)
			var newPosGlobal: Vector3 = self.global_position + dirVecToTarget * (distToTarget - teleportToDistance)
			self.set_global_position(newPosGlobal)
	else:
		printerr("No obj found of name: " + targetNodePath.get_concatenated_names())

func _on_body_entered(body: Node3D):
	if (body.is_in_group("Player")):
		body.addXP(self.xp)	# give xp in this gem
		self.queue_free()	# die
