extends Node2D

const action_point_scene = preload("res://scenes/ActionPoint.tscn")

export (int) var MAX_ACTIONS = 3

var available_actions

func _ready() -> void:
	Global.change_state(Global.State.PLANNING)
	available_actions = MAX_ACTIONS
	$UI.show()
	$UI/Count.text = str(available_actions)
	
func _input(event: InputEvent) -> void:
	if Global.get_state() == Global.State.PLANNING:
		if event.is_action_pressed("add_action_point") and !event.is_echo():
			if available_actions > 0:
				$Audio.click()
				_spawn_action_point(get_global_mouse_position())
				available_actions -= 1
			elif available_actions == 0:
				$Audio.click()
				Global.change_state(Global.State.ACTION)
				$UI.hide()
				$Player.set_target($ActionPoints.get_child(0))
		elif event.is_action_pressed("remove_action_point") and !event.is_echo():
			if available_actions < MAX_ACTIONS:
				$Audio.click()
				_remove_last_action_point()
		$UI/Count.text = str(available_actions)

func _spawn_action_point(coords: Vector2) -> void:
	var point = action_point_scene.instance()
	point.count = MAX_ACTIONS - available_actions + 1
	$ActionPoints.add_child(point)
	point.global_position = coords
	
func _remove_last_action_point() -> void:
	var last_child = $ActionPoints.get_child($ActionPoints.get_child_count() - 1)
	$ActionPoints.remove_child(last_child)
	last_child.queue_free()
	available_actions += 1

func _target_next_action_point() -> void:
	var target = $Player.get_target()
	$ActionPoints.remove_child(target)
	target.queue_free()
	if $ActionPoints.get_child_count() > 0:
		$Player.set_target($ActionPoints.get_child(0))
	else:
		$Player.set_target(null)
		print("no action point left")
		_retry()

func _on_Player_area_entered(area: Area2D) -> void:
	if area.is_in_group("exit"):
		if $Documents.get_child_count() == 0:
			Global.succeeded()
			$Audio.success()
			yield($Audio, "audio_finished")
			get_tree().change_scene(Global.get_next_level())
		else:
			print("not all documents collected")
			_retry()
	elif area.is_in_group("action_point"):
		_target_next_action_point()
	elif area.is_in_group("document"):
		$Audio.document()
		area.get_parent().remove_child(area)
		area.queue_free()
	elif area.is_in_group("wall"):
		print("collided with wall")
		_retry()
			
func _retry():
	Global.failed()
	$Audio.hurt()
	get_tree().reload_current_scene()

func _on_player_seen():
	print("player seen")
	_retry()
