class_name MovementComponent
extends BaseComponent

@export var walk_speed: float = 1
@export var run_speed_multiplication: float = 1.5
@export var is_running := false
@export_group("Smooth Movement")
@export_range(0, 0.2, 0.001) var acceleration: float = 0.25
@export_range(0, 0.2, 0.001) var deceleration: float = 0.25
@export_group("Appearance")
@export var walk_sound: AudioStreamPlayer2D
@export var walk_particles: CPUParticles2D


func move(velocity: Vector2, direction: Vector2) -> Vector2:
	if direction != Vector2.ZERO:
		var final_velocity := direction * walk_speed
		
		if is_running:
			final_velocity *= run_speed_multiplication
	
		if walk_sound and walk_sound.playing == false:
			walk_sound.play()
		if walk_particles and walk_particles.emitting == false:
			walk_particles.emitting = true
		
		return lerp(velocity, final_velocity, acceleration)
	
	else:
		if walk_sound and walk_sound.playing == true:
			walk_sound.stop()
		if walk_particles and walk_particles.emitting == true:
			walk_particles.emitting = false
		
		return lerp(velocity, Vector2.ZERO, deceleration)
