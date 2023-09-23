extends Powerup

@export var increase: float

func _handle_player_collision(player):
	player.speed += increase
