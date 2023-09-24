extends RigidBody2D
class_name Powerup

@onready var particle = preload("res://nodes/particle.tscn")

func _ready():
	rotation_degrees = randf_range(-PI, PI)

func _process(_delta):
	if position.y >= 700:
		queue_free()

func _handle_player_collision(_player):
	pass

func _on_body_entered(body):
	if body.name == "Circle":
		_handle_player_collision(body)
		
		var instance = particle.instantiate()
		instance.position = position
		add_sibling(instance)
		queue_free()
