extends Area2D

enum State {
	PATROL,
	STOP
}

export (int) var speed = 3

onready var path: PathFollow2D = get_parent()

var state = State.PATROL

func _physics_process(delta):
	if state == State.PATROL:
		path.offset += speed
	else:
		pass

func stop():
	state = State.STOP
