extends Node2D

const action_point_scene = preload("res://scenes/ActionPoint.tscn")
const MIN_SPEED = 2
const MAX_SPEED = 10
const SPEED_STEP = 1

enum State {
	PLANNING,
	ACTION,
	STOP
}

export (int) var MAX_ACTIONS = 3

var current_state = State.PLANNING
var current_target
var current_speed = MIN_SPEED
var available_actions

func _ready() -> void:
	available_actions = MAX_ACTIONS
	current_state = State.PLANNING
	current_speed = MIN_SPEED
	
func _physics_process(delta):
	if current_state == State.ACTION:
		if current_target:
			var velocity = $Player.global_position.direction_to(current_target.global_position) * current_speed
			$Player.global_position += velocity
		else:
			print("failure")
			current_state = State.STOP
	
func _input(event: InputEvent) -> void:
	if current_state == State.PLANNING:
		if event.is_action_pressed("add_action_point") and !event.is_echo():
			if available_actions > 0:
				_spawn_action_point(get_global_mouse_position())
				available_actions -= 1
			elif available_actions == 0:
				_run_action_phase()
		elif event.is_action_pressed("remove_action_point") and !event.is_echo():
			if available_actions < MAX_ACTIONS:
				_remove_last_action_point()
	elif current_state == State.ACTION:
		if event.is_action_pressed("speed_up") and !event.is_echo():
			current_speed = min(current_speed + SPEED_STEP, MAX_SPEED)
		elif event.is_action_pressed("speed_down") and !event.is_echo():
			current_speed = max(current_speed - SPEED_STEP, MIN_SPEED)

func _spawn_action_point(coords: Vector2) -> void:
	var point = action_point_scene.instance()
	$ActionPoints.add_child(point)
	point.global_position = coords
	
func _remove_last_action_point() -> void:
	var last_child = $ActionPoints.get_child($ActionPoints.get_child_count() - 1)
	$ActionPoints.remove_child(last_child)
	last_child.queue_free()
	available_actions += 1

func _run_action_phase() -> void:
	current_state = State.ACTION
	current_target = $ActionPoints.get_child(0)
	
func _target_next_action_point() -> void:
	$ActionPoints.remove_child(current_target)
	current_target.queue_free()
	if $ActionPoints.get_child_count() > 0:
		current_target = $ActionPoints.get_child(0)
	else:
		current_target = null
	
func _on_Player_area_entered(area: Area2D) -> void:
	# prevent losing when last point is reached at same time as exit
	if area.is_in_group("exit"):
		current_state = State.STOP
		print("success")
	elif area.is_in_group("action_point"):
		_target_next_action_point()
	elif area.is_in_group("document"):
		area.get_parent().remove_child(area)
		area.queue_free()

func _on_player_seen():
	current_state = State.STOP
	print("failure")
