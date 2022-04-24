extends Node2D

const text = "'Welcome, Agent.\nWe will send you to steal some secret documents.\n\nYou will use the\nCarelessly\nHacked\nAction\nInjection\nNibbler\nor C.H.A.I.N. in short.'"
var counter = 0
var length = 0

func _process(delta):
	counter += delta
	if counter > 0.05 and length < text.length():
		counter = 0
		length += 1
		$Text.text = text.substr(0, length)

func _input(event):
	if event.is_action_pressed("add_action_point") and !event.is_echo():
		if length < text.length():
			length = text.length()
			$Text.text = text
		else:
			get_tree().change_scene("res://scenes/Tutorial.tscn")
