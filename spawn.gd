extends Node2D

var enemy = preload("res://Enemy.tscn")
var spawn_random

func _ready():
	set_process(true)
	pass # Replace with function body.

func _process(delta):
	spawn_random = Global.random_rate
	if spawn_random == 199:
		var enemy_instance = enemy.instance()
		enemy_instance.set_name("enemy(Clone)")
		get_node(".").add_child(enemy_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.	
#func _process(delta):
#	pass
