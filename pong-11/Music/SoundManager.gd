extends AnimationPlayer

class_name SoundManager11

var sounds: SoundResource11 = SoundResource11.new()
var streamPlayer: NodePath = "/root/Node2D/SoundStream"

var wallBounceFile: Resource = preload("res://Music/Bounce.wav")
var wallBounceLength: float = 0.09

var playerWinFile: Resource = preload("res://Music/PlayerWin.wav")
var playerWinLength: float = 0.74

var playerLoseFile: Resource = preload("res://Music/PlayerLose.wav")
var playerLoseLength: float = 1.45

var loseRoundFile: Resource = preload("res://Music/LoseRound.wav")
var loseRoundLength: float = 2.39

var winRoundFile: Resource = preload("res://Music/WinRound.wav")
var winRoundLength: float = 0.29

func _ready() -> void:
	self.name = "SoundManager"
	self.add_animation("WallBounce", sounds.createSound(wallBounceFile, streamPlayer, wallBounceLength))
	self.add_animation("WinPoint", sounds.createSound(playerWinFile, streamPlayer, playerWinLength))
	self.add_animation("LosePoint", sounds.createSound(playerLoseFile, streamPlayer, playerLoseLength))
	self.add_animation("LoseRound", sounds.createSound(loseRoundFile, streamPlayer, loseRoundLength))
	self.add_animation("WinRound", sounds.createSound(winRoundFile, streamPlayer, winRoundLength))

func playBounce() -> void:
	self.play("WallBounce")

func playWinPoint() -> void:
	self.play("WinPoint")

func playLosePoint() -> void:
	self.play("LosePoint")

func playLoseRound() -> void:
	self.play("LoseRound")

func playWinRound() -> void:
	self.play("WinRound")
