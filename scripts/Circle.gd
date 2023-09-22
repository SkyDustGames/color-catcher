extends RigidBody2D

@export var speed: float
@onready var sprite = $Sprite2D

# --- UI --- #
@onready var scoreText = $"../../CanvasLayer/Score"
@onready var highscoreText = $"../../CanvasLayer/Highscore"
@onready var livesText = $"../../CanvasLayer/Lives"

var movement: float
var color
var effect = preload("res://nodes/explosion.tscn")

var score = 0
var highscore: int
var lives = 3

func _ready():
	highscore = Global.save.get("score", 0)
	highscoreText.text = "Highscore: " + str(highscore)
	set_color(Global.colors[randi() % Global.colors.size()])

func _process(_delta):
	if Input.is_action_just_pressed("move_right"):
		movement = 1
	elif Input.is_action_just_pressed("move_left"):
		movement = -1

	if Input.is_action_just_released("move_right"):
		movement = -1 if Input.is_action_pressed("move_left") else 0
	if Input.is_action_just_released("move_left"):
		movement = 1 if Input.is_action_pressed("move_right") else 0

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
	
func damage():
	lives -= 1
	livesText.text = "Lives: " + str(lives)
	if lives <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
