extends Camera2D

@export var max_offset := 500.0
var is_zooming: bool = false

func _process(_delta: float) -> void:
	_follow_mouse()
	_handle_zoom()

func _follow_mouse() -> void:
	var mouse_vector: Vector2 = get_global_mouse_position() - global_position
	var length := mouse_vector.length()
	var direction := mouse_vector.normalized()
	
	var clamped_length: float = clamp(length, 1, max_offset)
	var final_offset := direction * clamped_length / 10
	
	offset = lerp(offset, final_offset, 0.05)

func _handle_zoom() -> void:
	if is_zooming: return
	
	# Get if zoom in or zoom out
	var mode: int = 0
	if Input.is_action_just_released("zoom-in"):
		mode = 1
	elif Input.is_action_just_released("zoom-out"):
		mode = -1
	
	if mode == 0: return
	
	# Get the final zoom
	var final_zoom: Vector2 = zoom * 2 if mode == 1 else zoom / 2
	final_zoom = final_zoom.clampf(0.25, 1)
	
	if final_zoom == zoom: return
	
	# Apply the tween
	is_zooming = true
	var zoom_tween: Tween = create_tween()
	zoom_tween.set_ease(Tween.EASE_IN_OUT)
	zoom_tween.tween_property(self, "zoom",  final_zoom, 0.25)
	zoom_tween.tween_callback(func() -> void: is_zooming = false)
