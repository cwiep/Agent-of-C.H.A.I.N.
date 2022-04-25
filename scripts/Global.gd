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
	"res://scenes/Level04.tscn",
	"res://scenes/Level05.tscn",
	"res://scenes/Level06.tscn",
	"res://scenes/Level07.tscn",
	"res://scenes/Finish.tscn"
]
var current_level = 0
var start_time = 0

func reset():
	current_level = 0
	start_time = OS.get_unix_time()
	_current_state = State.PLANNING

func change_state(state) -> void:
	_current_state = state
	
func get_state():
	return _current_state

func failed() -> void:
	print("failure")
	_current_state = State.STOP

func succeeded() -> void:
	print("success")
	_current_state = State.STOP
	
func get_next_level():
	current_level += 1
	return levels[current_level]

func get_time():
	return OS.get_unix_time() - start_time
