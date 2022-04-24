extends Area2D

const MIN_SPEED = 2
const MAX_SPEED = 10
const SPEED_STEP = 1

var _current_target = null
var current_speed = MIN_SPEED

func _ready():
	current_speed = MIN_SPEED
	
func _physics_process(delta):
	if Global.get_state() == Global.State.ACTION:
		if _current_target:
			var velocity = global_position.direction_to(_current_target.global_position) * current_speed
			global_position += velocity
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.stop()
			print("no action point left")
			Global.failed()

func _input(event):
	if Global.get_state() == Global.State.ACTION:
		if event.is_action_pressed("speed_up") and !event.is_echo():
			current_speed = min(current_speed + SPEED_STEP, MAX_SPEED)
		elif event.is_action_pressed("speed_down") and !event.is_echo():
			current_speed = max(current_speed - SPEED_STEP, MIN_SPEED)

func set_target(target) -> void:
	_current_target = target

func get_target():
	return _current_target
