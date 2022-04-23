extends Path2D

signal player_seen

func _on_area_entered(area):
	if !area.is_in_group("player"):
		return
		
	$FollowAndRotate/VisionCone.stop()
	$Follow/Guard.stop()
	$Follow/Guard/AnimationPlayer.play("exited")
	yield($Follow/Guard/AnimationPlayer, "animation_finished")
	emit_signal("player_seen")
