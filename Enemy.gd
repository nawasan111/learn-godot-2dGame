extends KinematicBody2D
var wait_time = 0.0
var end_time = 0.2
var hp = 3.0
var destroy_time = 0.2

func _ready():
	set_process(true)
	pass # Replace with function body.

func _physics_process(delta):
	translate(Vector2(-1, 0))
	var collision = move_and_collide(Vector2(0, 5))
	if collision:
		if collision.collider.name == "Bullet(Clone)":
			hp = hp - 1
		if collision.collider.name == "Player":
			queue_free()
		
	if hp <= 0:
		wait_time += delta
		if wait_time > end_time:
			translate(Vector2(0, 0))
			get_node("AnimatedSprite").play("down")
			get_node("CollisionShape2D").disabled = true
			if wait_time >= destroy_time:
				destroy()

func destroy():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
