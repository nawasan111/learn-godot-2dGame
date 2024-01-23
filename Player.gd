extends KinematicBody2D
var input_direction = 0
var direction = 0
var speed = 0
var velocity = 0

const MAX_SPEED = 250
const ACCELERATION = 700
const DECERATION = 600
const JUMP_FOURCE = 10.0

var is_attack_pressed = false
var fire_rate = 0.0
var next_fire = 1

func _ready():
	pass

func _physics_process(delta):
	
	move_and_collide(Vector2(0, 5))
	
	if input_direction:
		direction = input_direction
		Global.global_direction = input_direction	
	
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
	
	#Attack
	if Input.is_key_pressed(KEY_P):
		get_node("AnimatedSprite").play("attack")
		if is_attack_pressed == false:
			fire()
			is_attack_pressed = true	
		
	fire_rate += delta
	if fire_rate >= next_fire:
		fire_rate = 0.0
		is_attack_pressed = false
		get_node("AnimatedSprite").play("Idle")	
	pass
	
	
func fire():
	var project_title = preload("res://Bullet.tscn")
	var bullet_instance = project_title.instance()
	bullet_instance.set_name("Bullet(Clone)")
	add_child_below_node(get_tree().get_root().get_node("."), bullet_instance)
	
