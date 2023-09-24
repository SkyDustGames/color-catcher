extends Control

@onready var root = $".."

func _ready():
	$Highscore.text = "Highscore: " + str(Global.save.score)

func settings():
	root.change_active($"../Settings")

func skins():
	root.change_active($"../Skins")
