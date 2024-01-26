extends AudioStreamPlayer3D

# used to make some common audio behaviors easier to drop into scenes
# needs to be attached to an AudioStreamPlayer3D
# customize AudioStreamPlayer3D instance for more customization options and to select bus

@export var chanceToPlay: float = 0 # 0-1. probability this plays music when it is supposed to.
@export var frequency: float = 1 # measured in multiples of the audio length
@export var deviation: float = 0 # 0-1. closer to zero means no deviation and will play at fixed intervals. closer to one means playing will be very random
@export var audioFiles: Array[AudioStream] = []

var nextIndexToPlay: int
var playTime: float
var extraWaitTime: float
var timeBetweenPlays: float
var audioDuration: float
var played: bool

func _ready():
	if (self.audioFiles.size() == 0):
		printerr("Need an audio file in order to operate!!")
	self.loadNext()
	self.timeBetweenPlays = self.playTime
	
func loadNext():
	self.nextIndexToPlay = randi_range(0, audioFiles.size() - 1)
	self.audioDuration = self.audioFiles[self.nextIndexToPlay].get_length()
	self.stream = self.audioFiles[self.nextIndexToPlay]
	if (self.frequency > 0):
		self.playTime = self.audioDuration * self.frequency
	else:
		self.playTime = self.audioDuration
	self.extraWaitTime = randf_range(0, self.playTime * self.deviation * 5)
	self.played = false

func _process(delta):
	self.timeBetweenPlays += delta
	# if not yet played and enough time has passed, play
	print("timeBetween: " + str(self.timeBetweenPlays) + " playTime+extra: " + str(self.playTime + self.extraWaitTime))
	if (!self.played && self.timeBetweenPlays > (self.playTime + self.extraWaitTime)):
		print("Attempting to Play Audio")
		if (randf() <= self.chanceToPlay):
			self.playAudio()
		self.played = true
		self.timeBetweenPlays = 0
	# if already played and entirely played out, loadnext and get ready to play
	elif (self.played && self.timeBetweenPlays > self.playTime):
		self.loadNext()

func playAudio():
	print("About to Play Audio")
	self.play()
	self.timeBetweenPlays = 0

func stopAudio():
	self.stop()
