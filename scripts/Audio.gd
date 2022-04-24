extends Node2D

signal audio_finished

func _ready():
	$Hurt.connect("finished", self, "_finished")
	$Click.connect("finished", self, "_finished")
	$Document.connect("finished", self, "_finished")
	$Success.connect("finished", self, "_finished")

func hurt():
	$Hurt.play()

func click():
	$Click.play()
	
func document():
	$Document.play()

func success():
	$Success.play()

func _finished():
	emit_signal("audio_finished")
