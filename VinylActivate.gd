extends Node2D

var dorotate:bool

@export var BPM:float = 1
@export var Disc:Sprite2D
@export var Music:AudioStreamPlayer

func _process(delta: float) -> void:
	if dorotate:
		Disc.rotation_degrees += BPM/20
		if !Music.playing:
			Music.playing = true
	else:
		Music.playing = false

func _on_one_pressed() -> void:
	dorotate = !dorotate
