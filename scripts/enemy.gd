extends Node2D

const SPEED = 25
var direction = 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft

func _process(delta):
	if ray_cast_right.is_colliding(): 
		direction = -1
		animated_sprite_2d.flip_h = true
	elif ray_cast_left.is_colliding(): 
		direction = 1
		animated_sprite_2d.flip_h = false
	position.x += SPEED * direction * delta
