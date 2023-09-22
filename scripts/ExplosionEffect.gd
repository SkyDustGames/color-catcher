extends Sprite2D

@export var speed = 2
@export var opacity_speed = 1
var animating_opacity = false

func _process(delta):
	if animating_opacity:
		modulate.a -= opacity_speed * delta
		if modulate.a <= 0:
			queue_free()
		return
	
	scale += Vector2(speed * delta, speed * delta)
	if scale.x >= 1:
		scale = Vector2(1, 1)
		animating_opacity = true
