extends AnimationPlayer

class_name SoundManager

var sounds: SoundResource = SoundResource.new()
onready var streamPlayer: NodePath = get_parent().get_path()

var bounceFile: Resource = preload("res://Music/Bounce.wav")
var bounceLength: float = bounceFile.get_length()
var bounceName: String = "Bounce"

var winPointFile: Resource = preload("res://Music/WinPoint.wav")
var winPointLength: float = winPointFile.get_length()
var winPointName: String = "WinPoint"

var losePointFile: Resource = preload("res://Music/LosePoint.wav")
var losePointLength: float = losePointFile.get_length()
var losePointName: String = "LosePoint"

var winRoundFile: Resource = preload("res://Music/WinRound.wav")
var winRoundLength: float = winRoundFile.get_length()
var winRoundName: String = "WinRound"

var loseRoundFile: Resource = preload("res://Music/LoseRound.wav")
var loseRoundLength: float = loseRoundFile.get_length()
var loseRoundName: String = "LoseRound"

func _ready() -> void:
	self.name = "SoundManager"
	self.add_animation(bounceName, sounds.createSound(bounceFile, streamPlayer, bounceLength))
	self.add_animation(winPointName, sounds.createSound(winPointFile, streamPlayer, winPointLength))
	self.add_animation(losePointName, sounds.createSound(losePointFile, streamPlayer, losePointLength))
	self.add_animation(winRoundName, sounds.createSound(winRoundFile, streamPlayer, winRoundLength))
	self.add_animation(loseRoundName, sounds.createSound(loseRoundFile, streamPlayer, loseRoundLength))


func playBounce() -> void:
	self.play(bounceName)

func playWinPoint() -> void:
	self.play(winPointName)

func playLosePoint() -> void:
	self.play(losePointName)

func playWinRound() -> void:
	self.play(winRoundName)

func playLoseRound() -> void:
	self.play(loseRoundName)


"""
1 sfx file = 5 lines of code
"""
