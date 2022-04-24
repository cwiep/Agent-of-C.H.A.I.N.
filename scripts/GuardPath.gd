extends PathFollow2D

signal player_seen

export (int) var speed = 3

func _on_area_entered(area):
	if Global.get_state() != Global.State.ACTION:
		return
	if !area.is_in_group("player"):
		return

	$Guard/AnimationPlayer.play("exited")
	emit_signal("player_seen")
	
