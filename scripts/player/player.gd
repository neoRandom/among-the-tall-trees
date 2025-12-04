class_name Player
extends CharacterBody2D

@onready var movement_component: MovementComponent = %MovementComponent
@onready var sprite: Sprite2D = %Sprite2D

const SPEED = 300.0


func _ready() -> void:
	Global.current_player = self


func _physics_process(_delta: float) -> void:
	movement()


func movement() -> void:
	var mouse_pos := get_local_mouse_position()
	if mouse_pos.x > 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	if Input.is_action_just_released("run"):
		movement_component.is_running = not movement_component.is_running
	
	var direction := Input.get_vector("left", "right", "upward", "downward")
	velocity = movement_component.move(velocity, direction)
	
	move_and_slide()


func _on_health_component_die() -> void:
	queue_free()
