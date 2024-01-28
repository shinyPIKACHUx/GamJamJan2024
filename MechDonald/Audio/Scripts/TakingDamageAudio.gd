extends Node

@export var audioFilesMap: Dictionary = {
	"cow": load("res://Assets/Sounds/Voices/mooing-cow-122255.mp3"),
	"pig": load("res://Assets/Sounds/Voices/pig-sound-43195.mp3"),
	"chicken": load("res://Assets/Sounds/Voices/chicken-single-alarm-call-6056.mp3"),
	"duck": load("res://Assets/Sounds/Voices/duck-quack-112941.mp3"),
	"sheep": load("res://Assets/Sounds/Voices/sheep-122256.mp3")
}

var audioPlayers: Dictionary
var longestAudioDuration: float
var audioTimer: float
var isPlaying: bool

func _ready():
	self.reset()
	for animalName in self.audioFilesMap:
		self.audioPlayers[animalName] = AudioStreamPlayerFactory.create(
			animalName + "AudioStreamPlayer",
			Enums.AudioStreamPlayerEnum.AudioStreamPlayer,
			self.audioFilesMap[animalName],
			Enums.BusEnum.Effects
		)
	for animalName in self.audioPlayers:
		self.add_child(self.audioPlayers[animalName])

func reset():
	self.isPlaying = false
	set_process(self.isPlaying)
	self.audioTimer = 0
	self.longestAudioDuration = 0

#disabled if isPlaying is false
func _process(delta):
	self.audioTimer += delta
	if (self.audioTimer >= self.longestAudioDuration): # ie, most no longer be playing
		self.reset()

func playAnimalNoises(animalNames: Array[String]):
	if (!self.isPlaying):
		if (!self.audioPlayers.has_all(animalNames)):
			printerr("Invalid Array given. Animal names are given that aren't set on the TakingDamageAudioPlayer")
			return
		for animalName in animalNames:
			if (self.longestAudioDuration < self.audioPlayers[animalName].get_length()):
				self.longestAudioDuration = self.audioPlayers[animalName].get_length()
			self.audioPlayers[animalName].play()
		self.isPlaying = true
		set_process(self.isPlaying)

func stopPlaying():
	self.reset()
	for animalName in self.audioPlayers:
		self.audioPlayers[animalName].stop()
