extends AnimationPlayer

class_name BackgroundManager11

var sounds: SoundResource11 = SoundResource11.new()

var backgroundPlayer: NodePath = "/root/Node2D/BackgroundStream"
var backgroundFile: Resource = preload("res://Music/BackgroundMusic.wav")
var backgroundLength: float = 74.25

func _ready() -> void:
	self.name = "BackgroundManager"
	self.add_animation("BackgroundMusic", sounds.createSound(backgroundFile, backgroundPlayer, backgroundLength, true))
	self.play("BackgroundMusic")
