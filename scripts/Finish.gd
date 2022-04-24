extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var time = Global.get_time()
	$Score.text = "Mission finished in %s seconds" % time
	
func _input(event):
	if event.is_action_pressed("add_action_point") and !event.is_echo():
		get_tree().change_scene("res://scenes/Menu.tscn")
