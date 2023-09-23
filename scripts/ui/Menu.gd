extends Control

@onready var tree = get_tree()
@export var active: Control
@export var disable_on_ready: Array[Control]

func _ready():
	for control in disable_on_ready:
		control.set_process(false)
		control.hide()

func play():
	tree.change_scene_to_file("res://scenes/game.tscn")

func back_to_menu():
	tree.change_scene_to_file("res://scenes/menu.tscn")

func quit():
	tree.quit(0)

func change_active(new: Control):
	if active != null:
		active.set_process(false)
		active.hide()
	active = new
	new.set_process(true)
	new.show()
