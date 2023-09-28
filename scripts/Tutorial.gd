extends Node2D

var allow_spawn = false
var indicator = preload("res://nodes/tutorial/indicator.tscn")
@onready var player = $Circle

func _ready():
	if OS.get_model_name() == "GenericDevice":
		show_pc_controls()

func show_pc_controls():
	var arrow = load("res://sprites/tutorial/arrow.png")
	$MovementControls/Left.texture = arrow
	$MovementControls/Left.flip_h = true
	$MovementControls/Right.texture = arrow

func _input(event):
	if not allow_spawn:
		if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
			$MovementControls.queue_free()
			allow_spawn = true

func on_player_damage(lives):
	if lives < 3:
		$"../CanvasLayer/Warning".show()
		$"../CanvasLayer/Warning/AnimationPlayer".play("flash")
		await get_tree().create_timer(2).timeout
		$"../CanvasLayer/Warning".hide()

func on_player_score(score):
	if score >= 5:
		Global.write_save(Global.save)
		SceneTransition.change_scene("res://scenes/menu.tscn")

func spawned(new_shape, powerup):
	if allow_spawn:
		if powerup or new_shape.color == player.color:
			var new_indicator = indicator.instantiate()
			new_shape.add_child(new_indicator)
	else:
		new_shape.queue_free()
