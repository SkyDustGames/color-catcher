extends RigidBody2D

signal player_lives_changed(lives)
signal player_score_changed(score)

@export var speed: float
@onready var sprite = $Sprite2D

# --- UI --- #
@onready var scoreText = $"../../CanvasLayer/Score"
@onready var highscoreText = $"../../CanvasLayer/Highscore"
@onready var hearts = $"../../CanvasLayer/Lives".get_children()

var movement: float
var color
var effect = preload("res://nodes/explosion.tscn")

var score = 0
var highscore: int
var lives = 3

func _ready():
	highscore = Global.save.get("score", 0)
	highscoreText.text = "Highscore: " + str(highscore)
	color = Global.colors[randi() % Global.colors.size()]
	sprite.modulate = color
	sprite.texture = Global.skin

func _process(_delta):
	if Input.is_action_just_pressed("move_right"):
		movement = 1
	elif Input.is_action_just_pressed("move_left"):
		movement = -1
	if Input.is_action_just_released("move_right"):
		movement = -1 if Input.is_action_pressed("move_left") else 0
	if Input.is_action_just_released("move_left"):
		movement = 1 if Input.is_action_pressed("move_right") else 0
	
	if Input.is_action_just_pressed("slow_down"):
		toggle_slow()

func toggle_slow():
	Engine.time_scale = 0.5 if Engine.time_scale == 1 else 1.0

func _physics_process(delta):
	position.x += movement * speed * delta
	
func set_color(c):
	color = c
	sprite.modulate = color
	
	var instance = effect.instantiate()
	instance.modulate = color
	instance.position = position
	get_parent().add_child.call_deferred(instance)

func add_score():
	score += 1
	if score > highscore:
		highscore = score
		highscoreText.text = "Highscore: " + str(highscore)
		Global.save["score"] = highscore

	scoreText.text = "Score: " + str(score)
	player_score_changed.emit(score)
	SoundManager.play("collect")

func heal():
	player_lives_changed.emit(3 if lives >= 3 else lives + 1)
	if lives >= 3:
		return
	hearts[lives].show()
	lives += 1

func damage():
	lives -= 1
	hearts[lives].hide()
	player_lives_changed.emit(lives)
	if lives <= 0:
		Global.save.coins += score
		Global.write_save(Global.save)
		SceneTransition.change_scene("res://scenes/game_over.tscn")
		SoundManager.play_music("hush_hamlet")
	SoundManager.play("explosion")
