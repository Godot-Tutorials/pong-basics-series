extends AnimationPlayer

class_name BackgroundManager

var sounds: SoundResource = SoundResource.new()
onready var backgroundPlayer: NodePath = get_parent().get_path()


var dictionary: Dictionary = {
	"BackgroundMusic" : "res://Music/BackgroundMusic.wav"
}

func _ready() -> void:
	self.name = "BackgroundManager"
	
	for key in dictionary:
		var backgroundFile: Resource = load(dictionary[key])
		var backgroundMusicName: String = key
		var backgroundLength: float = backgroundFile.get_length()
		self.add_animation(backgroundMusicName, sounds.createSound(backgroundFile, backgroundPlayer, backgroundLength, true))
	playSong() 
	

func playSong(songName := "BackgroundMusic") -> void:
	self.play(songName)

"""
1 music file = 1 line of code
"""
