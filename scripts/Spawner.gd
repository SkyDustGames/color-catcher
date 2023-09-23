extends Timer

var shapes = [
	preload("res://nodes/shapes/square.tscn"),
	preload("res://nodes/shapes/circle.tscn"),
	preload("res://nodes/shapes/triangle.tscn"),
	preload("res://nodes/shapes/hexagon.tscn")
]

@export var time_decrease: float
@export var min_time: float

func _ready():
	randomize()

func _on_timeout():
	var shape_kind = shapes[randi() % shapes.size()]
	var shape = shape_kind.instantiate()
	shape.position = Vector2(randi_range(0, 1200), -100)
	add_child(shape)
	
	var t = wait_time - time_decrease
	if t <= min_time:
		wait_time = min_time
	else:
		wait_time = t
