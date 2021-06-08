extends Resource

class_name SoundResource11

func createSound(soundFile: Resource, audioStreamNode: NodePath, length: float, isLoop := false) -> Animation:
	var sound: Animation = Animation.new()
	var trackIndex = sound.add_track(Animation.TYPE_AUDIO)
	var START_AT_ZERO: float = 0.0
	
	sound.set_length(length) # Length needs to be equal to or greater than length of song
	sound.set_loop(isLoop) # allow the music to loop
	sound.track_set_path(trackIndex, audioStreamNode)
	sound.audio_track_insert_key(trackIndex, START_AT_ZERO, soundFile)
	
	return sound # returns an animation resource (data container)
