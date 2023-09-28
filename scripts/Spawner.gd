extends Timer

signal spawned(new_shape, powerup)

var shapes = [
	preload("res://nodes/shapes/square.tscn"),
	preload("res://nodes/shapes/circle.tscn"),
	preload("res://nodes/shapes/triangle.tscn"),
	preload("res://nodes/shapes/hexagon.tscn")
]

var powerups = [
	preload("res://nodes/powerups/speed.tscn"),
	preload("res://nodes/powerups/heal.tscn")
]

@export var time_decrease: float
@export var min_time: float
@export var powerup_chance: float

func _ready():
	randomize()

func spawn(list):
	var object = list[randi() % len(list)].instantiate()
	object.position = Vector2(randi_range(0, 1200), -100)
	add_child(object)
	return object

func set_shape_color(shape, player):
	shape.set_color(Global.colors[randi() % len(Global.colors)])
	while shape.color == player.color:
		shape.set_color(Global.colors[randi() % len(Global.colors)])

func _on_timeout():
	if randf() < powerup_chance:
		var powerup = spawn(powerups)
		spawned.emit(powerup, true)
	else:
		var shape = spawn(shapes)
		var player = $"../Circle"
		if shape.name == (Global.save.skin + "Shape"):
			shape.set_color(player.color)
		else:
			set_shape_color(shape, player)
		spawned.emit(shape, false)
	
	var t = wait_time - time_decrease
	if t <= min_time:
		wait_time = min_time
	else:
		wait_time = t
