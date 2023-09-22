extends Control

@onready var root = $".."

func settings():
	root.change_active($"../Settings")

func skins():
	root.change_active($"../Skins")
