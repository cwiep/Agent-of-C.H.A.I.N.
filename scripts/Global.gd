extends Node

enum State {
	PLANNING,
	ACTION,
	STOP
}

var _current_state = State.PLANNING

func change_state(state) -> void:
	_current_state = state
	
func get_state():
	return _current_state

func failed() -> void:
	print("failure")
	# TODO reload level
	_current_state = State.STOP

func succeeded() -> void:
	print("success")
	# TODO load next level
	_current_state = State.STOP
