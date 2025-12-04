extends Node


func _process(_delta: float) -> void:
	if Input.is_action_just_released("fullscreen"):
		_toggle_fullscreen()


func _toggle_fullscreen() -> void:
	var window_mode := DisplayServer.WINDOW_MODE_FULLSCREEN
	
	if DisplayServer.window_get_mode() == window_mode:
		window_mode = DisplayServer.WINDOW_MODE_WINDOWED
	
	DisplayServer.window_set_mode(window_mode)
	print("Toggled fullscreen!")
