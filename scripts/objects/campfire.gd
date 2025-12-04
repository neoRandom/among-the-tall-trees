class_name CampfireObject
extends StaticBody2D

@onready var heal_area: Area2D = %HealRadius
@onready var collision_shape: CollisionShape2D = %CollisionShape2D

var _radius: float = 10.0

@export var heal_amount: float = 10.0
@export var heal_cooldown: float = 1.0
@export var heal_radius: float = 300.0:
	get:
		return _radius
	set(new_value):
		_radius = new_value
		_update_shape_radius(_radius) 

var heal_cooldowns: Dictionary = {}

func _process(_delta: float) -> void:
	var overlapping_bodies: Array[Node2D] = heal_area.get_overlapping_bodies()
	var current_time: float = Time.get_ticks_msec() / 1000.0
	
	for body in overlapping_bodies:
		if not (body is Player): continue
		
		var player: Player = body
		var player_id: int = player.get_instance_id()
		
		var last_hit_time: float = heal_cooldowns.get(player_id, 0.0)
		if current_time < last_hit_time + heal_cooldown: continue
		
		var health_component: HealthComponent = body.get_node("Components/HealthComponent")
		if not health_component: continue
		
		health_component.take_heal(heal_amount)
		heal_cooldowns[player_id] = current_time


func _on_heal_radius_body_exited(body: Node2D) -> void:
	if body is Player:
		var player_id: int = body.get_instance_id()
		
		if not heal_cooldowns.has(player_id):
			return
		
		heal_cooldowns.erase(player_id)


func _update_shape_radius(new_radius: float) -> void:
	var shape: Shape2D = collision_shape.shape
	
	if shape and shape is CircleShape2D:
		var circle_shape: CircleShape2D = shape
		circle_shape.radius = new_radius
	else:
		if not shape:
			shape = CircleShape2D.new()
			shape.radius = new_radius
