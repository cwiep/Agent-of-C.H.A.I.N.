extends Area2D

onready var path: PathFollow2D = get_parent()

func _physics_process(delta):
	if Global.get_state() == Global.State.STOP:
		return
	path.offset += path.speed
