extends Control

@onready var tree = get_tree()
@export var active: Control
@export var disable_on_ready: Array[Control]

func _ready():
	for control in disable_on_ready:
		control.set_process(false)
		control.hide()

func play():
	SoundManager.play_music("old_tricks")
	SoundManager.play("select")
	SceneTransition.change_scene("res://scenes/game.tscn")

func back_to_menu():
	SoundManager.play_music("the_cool_factor")
	SoundManager.play("select")
	SceneTransition.change_scene("res://scenes/menu.tscn")

func quit():
	SoundManager.play("select")
	Global.write_save(Global.save)
	tree.quit(0)

func change_active(new: Control):
	SoundManager.play("select")
	if active != null:
		active.set_process(false)
		active.hide()
	active = new
	new.set_process(true)
	new.show()
