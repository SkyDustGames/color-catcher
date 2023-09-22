extends RigidBody2D

var color

func _ready():
	var sprite = $Sprite2D
	color = Global.colors[randi() % Global.colors.size()]
	sprite.modulate = color
	rotation_degrees = randf_range(-PI, PI)

func _process(_delta):
	if position.y >= 700:
		queue_free()
		
func handle_player_collision(player):
	if player.color == color:
		player.add_score()
		player.set_color(Global.colors[randi() % Global.colors.size()])
	else:
		player.damage()
		player.set_color(color)
	queue_free()

func _on_body_entered(body):
	if body.name == "Circle":
		handle_player_collision(body)
