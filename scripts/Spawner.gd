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

func _on_timeout():
	if randf() < powerup_chance:
		var power = powerups[randi() % powerups.size()]
		var powerup = power.instantiate()
		powerup.position = Vector2(randi_range(0, 1200), -100)
		add_child(powerup)
		spawned.emit(powerup, true)
	else:
		var shape_kind = shapes[randi() % shapes.size()]
		var shape = shape_kind.instantiate()
		shape.position = Vector2(randi_range(0, 1200), -100)
		add_child(shape)
		spawned.emit(shape, false)
	
	var t = wait_time - time_decrease
	if t <= min_time:
		wait_time = min_time
	else:
		wait_time = t
