extends Label

var health_component: HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var current_player: Player = await Global.player_defined
	health_component = current_player.get_node("Components/HealthComponent")

func _process(_delta: float) -> void:
	if health_component:
		text = "HEALTH: %.2f / %.2f" % [health_component.health, health_component.max_health]
