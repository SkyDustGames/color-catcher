extends Control
class_name Skins

static var skins = {
	"Circle": {
		"sprite": preload("res://sprites/circle.png"),
		"cost": 0,
	},
	"Square": {
		"sprite": preload("res://sprites/square.png"),
		"cost": 10,
	},
	"Triangle": {
		"sprite": preload("res://sprites/triangle.png"),
		"cost": 20,
	},
	"Hexagon": {
		"sprite": preload("res://sprites/hexagon.png"),
		"cost": 30,
	},
}

func back():
	$"..".change_active($"../Main")

func _ready():
	var grid = $GridContainer
	var template = $GridContainer/Template
	var display = $Skin
	var coins = $Coins
	
	var index = 0
	for skin in skins:
		var instance = template.duplicate()
		var label = instance.get_child(0)
		
		instance.texture_normal = skins[skin].sprite
		instance.texture_pressed = skins[skin].sprite
		instance.texture_disabled = skins[skin].sprite
		instance.texture_hover = skins[skin].sprite
		instance.texture_focused = skins[skin].sprite
		
		instance.pressed.connect(func():
			if Global.save["skins"].has(str(index)):
				Global.skin = skins[skin].sprite
				Global.save.skin = skin
				display.texture = skins[skin].sprite
				Global.write_save(Global.save)
				return
			
			if Global.save.coins >= skins[skin].cost:
				Global.save.coins -= skins[skin].cost
				coins.text = str(Global.save.coins) + " coins"
				instance.self_modulate = Color(1, 1, 1)
				label.queue_free()
				
				Global.save["skins"].append(str(index))
				Global.write_save(Global.save)
		)
		
		if Global.save["skins"].has(str(index)):
			instance.self_modulate = Color(1, 1, 1)
			label.queue_free()
		else:
			label.text = str(skins[skin].cost) + " coins"
		
		grid.add_child(instance)
		index += 1
	
	display.texture = skins[Global.save.skin].sprite
	coins.text = str(Global.save.coins) + " coins"
	template.queue_free()
