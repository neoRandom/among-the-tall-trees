class_name HurtboxComponent
extends Area2D

@export var health_component: HealthComponent
@export var hit_cooldown: float = 1.0

var hit_cooldowns: Dictionary = {}


func _process(_delta: float) -> void:
	var overlapping_areas: Array[Area2D] = get_overlapping_areas()
	var current_time: float = Time.get_ticks_msec() / 1000.0
	
	for area in overlapping_areas:
		if not (area is HitboxComponent): continue
		
		var hitbox: HitboxComponent = area
		var hitbox_id: int = hitbox.get_instance_id()
		
		var last_hit_time: float = hit_cooldowns.get(hitbox_id, 0.0)
		if current_time < last_hit_time + hit_cooldown: continue
		
		health_component.take_damage(hitbox.damage)
		hit_cooldowns[hitbox_id] = current_time


func _on_area_exited(area: Area2D) -> void:
	if area is HitboxComponent:
		var hitbox_id: int = area.get_instance_id()
		
		if not hit_cooldowns.has(hitbox_id):
			return
		
		hit_cooldowns.erase(hitbox_id)
