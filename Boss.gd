extends KinematicBody2D

var step_rate = 0
var step_do = 3
var direction = 0
var speed = 60
var velocity = 0
var hp = 20
var random_fire

func _ready():
	get_node("AnimatedSprite").play("Idle")
	_random_direction()
	pass

func _random_direction():
	var dump = rand_range(-1, 1)
	if dump < 0:
		direction = -1
	elif dump > 0:
		direction = 1
	pass
	
func _physics_process(delta):
	step_rate += delta
	velocity = (speed * delta + direction)
	random_fire = Global.random_rate
	if random_fire == 50:
		fire()
	if step_rate < step_do:
		var collision = move_and_collide(Vector2(velocity, 0))
		if collision:
			print(collision.collider.name)
			if collision.collider.name == "Bullet(Clone)":
				hp -= 1
				get_node("AnimatedSprite").play("hurt")
				stop_hurt()
	
	if hp <= 0:
		move_and_collide(Vector2(0, 0))
		get_node("AnimatedSprite").play("down")
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://Finish.tscn")
	
	if step_rate >= step_do:
		step_rate = 0
		direction = 0
		_random_direction()
	
func fire():
	var project_tile = preload("res://EnemyBullet.tscn")
	var enemy_bullet = project_tile.instance()
	enemy_bullet.set_name("enemy(Clone)")
	add_child_below_node(get_tree().get_root().get_node("."), enemy_bullet)
	pass

func stop_hurt():
	yield(get_tree().create_timer(1.0), "timeout")
	get_node("AnimatedSprite").play("Idle")
