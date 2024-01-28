extends Node3D

@export var audioType: Enums.AudioStreamPlayerEnum = Enums.AudioStreamPlayerEnum.AudioStreamPlayer
@export var busToUse : Enums.BusEnum = Enums.BusEnum.Master
@export var possibleSounds: Array[AudioStream] # sets possible voices & noises enemies can make
@export var frequency: float # number of times per second to attempt to play audio if not playing audio
@export var chanceToPlay: float # 0-1. Probability to play audio when attempting to play audio
@export var generatedNodeName: String = "IntermittentAudioGeneratorNode"
@export var groupToSearch: String = "Player"

var maxLength: int
var playing: bool
var audioDuration: float
var secondsBetweenPlayChecks: float
var audioTimer: float
var frequencyTimer: float
var playIndex: int
var audioNodeOnObject: Node

func _ready():
	self.maxLength = self.possibleVoices.size()
	if (maxLength == 0):
		printerr("EnemyVoiceGenerator requires at least 1 sound to be able to play. None given.")
	self.reset()

func reset():
	self.playing = false
	self.playIndex = randi_range(0, maxLength - 1)
	self.audioDuration = self.possibleVoices[self.playIndex].get_length()
	self.secondsBetweenPlayChecks = 1 / self.frequency
	self.audioTimer = 0
	self.frequencyTimer = 0
	self.audioNodeOnObject = null

func _process(delta):
	if (self.playing):
		self.audioTimer += delta
		if (self.audioTimer >= self.audioDuration): # audio done
			self.audioNodeOnObject.queue_free() # destroy audio node containing copy of audio on enemy
			self.reset()
	else:
		self.frequencyTimer += delta
		if (self.frequencyTimer >= self.secondsBetweenPlayChecks):
			self.attemptToPlay()

func attemptToPlay():
	if (randf() < self.chanceToPlay):
		var obj
		if (self.audioType == Enums.AudioStreamPlayerEnum.AudioStreamPlayer):
			obj = get_tree().root
		else:
			obj = grabRandomObject()
		if (obj == null):
			print("No " + self.groupToSearch + " found. Will not generate audio.")
			return
		self.audioNodeOnObject = AudioStreamPlayerFactory.create(
			self.generatedNodeName,
			self.audioType,
			self.possibleVoices[self.playIndex],
			busToUse
		)
		obj.add_child(self.audioNodeOnObject)
		self.audioNodeOnObject.play()
		self.playing = true
	self.frequencyTimer = 0
		
func grabRandomObject():
	var objs = get_tree().get_nodes_in_group(self.groupToSearch)
	if (objs.size() == 0):
		return null
	return objs[randi_range(0, objs.size() - 1)]
