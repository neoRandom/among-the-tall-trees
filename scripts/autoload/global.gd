class_name GlobalNode
extends Node

signal player_defined(new_player: Player)

var current_player: Player:
	set(new_player): player_defined.emit(new_player)
