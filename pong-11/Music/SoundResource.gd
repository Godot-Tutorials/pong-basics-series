extends Resource

class_name SoundResource11

func createSound(soundFile: Resource, audioStreamNode: NodePath, length: float, isLoop := false) -> Animation:
	var sound: Animation = Animation.new()
	var trackIndex: int = sound.add_track(Animation.TYPE_AUDIO)
	var START_AT_ZERO: float = 0.0
	
	sound.set_length(length) # Length needs to be greater than or equal to the length of the sound
	sound.set_loop(isLoop) # choose whether or not the music loops
	
	sound.track_set_path(trackIndex, audioStreamNode)
	sound.audio_track_insert_key(trackIndex, START_AT_ZERO, soundFile)
	
	return sound
