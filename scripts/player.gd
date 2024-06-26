extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 100.0
const JUMP_VELOCITY = -200.0

var on_ladder := false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	# Add the gravity if were not colliding with a ladder.
	if not is_on_floor(): 
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0: animated_sprite_2d.flip_h = false
	elif direction < 0: animated_sprite_2d.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else: animated_sprite_2d.play("run")
	else: 
		if velocity.y < 0: animated_sprite_2d.play("jump")
		else: animated_sprite_2d.play("fall")

	move_and_slide()

func _on_area_2d_body_entered(body):
	on_ladder = true


func _on_area_2d_body_exited(body:Node2D):
	on_ladder = false

