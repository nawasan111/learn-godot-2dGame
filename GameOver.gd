extends Node2D

func _process(delta):
	if Input.is_key_pressed(KEY_ENTER):
		yield(get_tree().create_timer(1.5), "timeout")
		get_tree().change_scene("res://Charactor.tscn")
	
