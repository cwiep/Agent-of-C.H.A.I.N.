extends Node

enum State {
	PLANNING,
	ACTION,
	STOP
}

var _current_state = State.PLANNING

var levels = [
	"res://scenes/Tutorial.tscn",
	"res://scenes/Level01.tscn",
	"res://scenes/Level02.tscn",
	"res://scenes/Level03.tscn",
	"res://scenes/World.tscn",
	"res://scenes/Finish.tscn"
]
var current_level = 0

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
	
func get_next_level():
	current_level += 1
	return levels[current_level]
