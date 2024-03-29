extends RigidBody2D

var color
@onready var sprite = $Sprite2D

func _ready():
	rotation_degrees = randf_range(-PI, PI)

func _process(_delta):
	if position.y >= 1000:
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

func set_color(new_color):
	color = new_color
	sprite.modulate = color
