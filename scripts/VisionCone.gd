extends Polygon2D

export (int) var speed = 3

onready var path: PathFollow2D = get_parent()

func _physics_process(delta):
	path.offset += speed

func _on_VisionCone_area_entered(area):
	pass # Replace with function body.
