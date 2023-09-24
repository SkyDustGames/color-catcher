extends Powerup

@export var increase: float
@export var max_speed: float

func _handle_player_collision(player):
	player.speed += increase
	if player.speed > max_speed:
		player.speed = max_speed
