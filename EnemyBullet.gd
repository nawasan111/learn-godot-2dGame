extends KinematicBody2D

var wait_time = 0.0
var visible_time = 0.5
var end_time = 7

func _ready():
	set_process(true)
	get_node("CollisionShape2D").disabled = true
	pass
	
func _process(delta):
	translate(Vector2(-2, 0))
	wait_time += delta
	if wait_time > visible_time:
		get_node("CollisionShape2D").disabled = false
		
	wait_time += delta
	if wait_time > end_time:
		wait_time = 0.0
		queue_free()
