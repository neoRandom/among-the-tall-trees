extends Label

func _process(delta: float) -> void:
	text = "DELTA: %f; FPS: %f" % [delta, Engine.get_frames_per_second()]
