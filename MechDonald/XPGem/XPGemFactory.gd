
# Usage:
#	var xpgem = XPGemFactory.create(100, $../Target)
#	add_node(xpgem)
#	# creates a new xpgem correctly and adds to the world

class_name XPGemFactory
# defaults to inheriting reference. Never meant to instantiate

const XPGemScene = preload("res://XPGem/XPGem.tscn")

static func create(
	xp: float,
	targetNodePath: NodePath,
	finalAttractThreshold: float = 7,
	slowlyApproachThreshold: float = 100,
	teleportToDistance: float = 90,
	slowlyApproachRate: float = 0.25,
	finalAttractDeltaLerpMultiplier: float = 0.4
):
	var inst = XPGemScene.instantiate()
	inst.xp = xp
	inst.targetNodePath = targetNodePath
	inst.finalAttractToTargetThreshold = finalAttractThreshold
	inst.slowlyApproachTargetThreshold = slowlyApproachThreshold
	inst.teleportToDistance = teleportToDistance
	inst.slowlyApproachRate = slowlyApproachRate
	inst.finalAttractDeltaLerpMultiplier = finalAttractDeltaLerpMultiplier
	return inst
