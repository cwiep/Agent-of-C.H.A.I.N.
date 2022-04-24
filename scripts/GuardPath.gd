extends PathFollow2D

export (float) var speed = 1

signal player_seen

func _on_area_entered(area):
	if Global.get_state() != Global.State.ACTION:
		return
	if !area.is_in_group("player"):
		return

	$Guard/AnimationPlayer.play("exited")
	Global.failed()
	yield($Guard/AnimationPlayer, "animation_finished")
	emit_signal("player_seen")
	
	
