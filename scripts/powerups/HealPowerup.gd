extends Powerup

func _handle_player_collision(player):
	player.heal()
