extends Node3D

@export var possibleNoises: Array[AudioStream] # sets possible noises enemies can make
@export var frequency: float # number of times per second to attempt to play audio if not playing audio
@export var chanceToPlay: float # 0-1. Probability to play audio when attempting to play audio

var maxLength: int
var playing: bool
var audioDuration: float
var secondsBetweenPlayChecks: float
var audioTimer: float
var frequencyTimer: float
var playIndex: int
var audioNodeOnEnemy: Node

func _ready():
	
	self.maxLength = self.possibleNoises.size()
	if (maxLength == 0):
		printerr("EnemyNoiseGenerator requires at least 1 sound to be able to play. None given.")
	self.reset()

func reset():
	self.playing = false
	self.playIndex = randi_range(0, maxLength - 1)
	self.audioDuration = self.possibleNoises[self.playIndex].get_length()
	self.secondsBetweenPlayChecks = 1 / self.frequency
	self.audioTimer = 0
	self.frequencyTimer = 0
	self.audioNodeOnEnemy = null

func _process(delta):
	if (self.playing):
		self.audioTimer += delta
		if (self.audioTimer >= self.audioDuration): # audio done
			self.audioNodeOnEnemy.queue_free() # destroy audio node containing copy of audio on enemy
			self.reset()
	else:
		self.frequencyTimer += delta
		if (self.frequencyTimer >= self.secondsBetweenPlayChecks):
			self.attemptToPlay()

func attemptToPlay():
	print("attempting to play")
	if (randf() < self.chanceToPlay):
		print("passed random check")
		var enemy = grabRandomEnemy()
		if (enemy == null):
			print("no enemy found. not trying to play anything.")
			return
		var audioToPlay = self.possibleNoises[self.playIndex]
		self.audioNodeOnEnemy = AudioStreamPlayer3D.new()
		self.audioNodeOnEnemy.set_name("NoiseAudioNode")
		self.audioNodeOnEnemy.stream = audioToPlay
		self.audioNodeOnEnemy.bus = "Noise"
		enemy.add_child(self.audioNodeOnEnemy)
		#self.audioNodeOnEnemy = enemy.find_child("NoiseAudioNode")
		self.audioNodeOnEnemy.play()
		print("playing")
		self.playing = true
	self.frequencyTimer = 0
		
func grabRandomEnemy():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	if (enemies.size() == 0):
		return null
	return enemies[randi_range(0, enemies.size() - 1)]
