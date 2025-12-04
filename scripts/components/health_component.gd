class_name HealthComponent
extends BaseComponent

signal heal(amount: float)
signal hit(damage: float)
signal die

@onready var regen_timer: Timer = %RegenTimer

@export_group("Health")
@export var max_health: float = 100.0:
	set(value): health = value
@export var health: float = 100.0

@export_group("Regeneration")
@export var regen_enabled: bool = true
@export var regen_value: float = 1.0
@export_range(0, 60, 0.01) var regen_interval: float = 1.0:
	set(new_value): if regen_timer: regen_timer.wait_time = new_value


func _ready() -> void:
	health = max_health
	regen_timer.wait_time = regen_interval
	regen_timer.timeout.connect(regen_health)


func regen_health() -> void:
	if regen_enabled:
		take_heal(regen_value)


func take_heal(amount: float) -> void:
	heal.emit(amount)
	
	if health + amount > max_health:
		health = max_health
	else:
		health += amount


func take_damage(damage: float) -> void:
	hit.emit(damage)
	
	if health > damage:
		health -= damage
	else:
		health = 0.0
		die.emit()
