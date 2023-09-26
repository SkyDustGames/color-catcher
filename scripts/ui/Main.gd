extends Control

@onready var root = $".."

func _ready():
	SoundManager.play_music("the_cool_factor")
	if Global.save.played:
		$Tutorial.show()
	$Highscore.text = "Highscore: " + str(Global.save.score)

func settings():
	root.change_active($"../Settings")

func skins():
	root.change_active($"../Skins")

func tutorial():
	SoundManager.play_music("starlight_city")
	SceneTransition.change_scene("res://scenes/tutorial.tscn")
