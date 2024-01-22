extends KinematicBody2D
var input_direction = 0
var direction = 0
var speed = 0
var velocity = 0

const MAX_SPEED = 250
const ACCELERATION = 700
const DECERATION = 600
const JUMP_FOURCE = 10.0

func _ready():
	pass

func _process(delta):
	
	move_and_collide(Vector2(0, 5))
	
	if input_direction:
		direction = input_direction	
	
	if Input.is_action_pressed("ui_left"):
		input_direction = -1
		get_node("AnimatedSprite").set_flip_h(false	)
		get_node("AnimatedSprite").play("walk")
	elif Input.is_action_pressed("ui_right"):
		input_direction = 1
		get_node("AnimatedSprite").set_flip_h(true)
		get_node("AnimatedSprite").play("walk")
	else:
		input_direction = 0
		get_node("AnimatedSprite").play("Idle")
		
	if input_direction == -direction:
		speed /= 4
				
	if input_direction:
		speed += ACCELERATION * delta
	else:
		speed -= DECERATION * delta
		
	speed = clamp(speed, 0, MAX_SPEED)
	velocity = speed * delta * direction
	move_and_collide(Vector2(velocity, 0))
	print(speed)
	
	#Jump
	if Input.is_action_pressed("ui_up"):
		get_node("AnimatedSprite").play("jump")
		move_and_collide(Vector2(0, -JUMP_FOURCE))
	
	pass
	
	
