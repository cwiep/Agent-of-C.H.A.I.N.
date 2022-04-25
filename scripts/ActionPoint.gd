extends Area2D

export (int) var count = 1

func _ready():
	$Count.text = str(count)
