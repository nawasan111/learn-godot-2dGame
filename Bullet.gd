extends KinematicBody2D

var bullet_sprite 
var wait_time = 0.0
var visible_time = 0.3
var end_time = 0.4


func _ready():
	set_process(true)
	bullet_sprite = get_node("Sprite")
	get_node("CollisionShape2D").disabled = true
	pass # Replace with function body.

func _process(delta):
	var bullet_direction = Global.global_direction
	if bullet_direction == -1 :
		bullet_sprite.set_flip_h(true)
		translate(Vector2(-5, 0))
	else:
		bullet_sprite.set_flip_h(false)
		translate(Vector2(5, 0))
		
	wait_time += delta
	if wait_time >visible_time:
		get_node("CollisionShape2D").disabled = false
		
	if wait_time > end_time:
		wait_time = 0.0
		destroy()
		

func destroy():
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
