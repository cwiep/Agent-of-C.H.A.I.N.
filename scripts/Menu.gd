extends Node2D

func _input(event):
	if event.is_action_pressed("add_action_point") and !event.is_echo():
		get_tree().change_scene("res://scenes/Intro.tscn")
