extends Node2D

var text = "'Welcome, Agent.\nWe will send you to steal some secret documents.\n\nYou will use the\nCarelessly\nHacked\nAction\nInjection\nNeuroaction-o-meter\nor C.H.A.I.N. in short.'"
var text2 = "'With C.H.A.I.N. you are able to plan your chain of actions in a very detailed fashion as the following introduction shall explain.\n\nOh, and\nDON'T LOSE C.H.A.I.N.\n... we only have one!"
var counter = 0
var length = 0
var next_text = false

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
		elif !next_text:
			next_text = true
			text = text2
			length = 0
		elif next_text:
			get_tree().change_scene("res://scenes/Tutorial.tscn")
