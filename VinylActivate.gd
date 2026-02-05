extends Node2D

var dorotate:bool

@export var Speed:float = 1
@export var Disc:Sprite2D
@export var Music:AudioStreamPlayer

func _process(delta: float) -> void:
	if dorotate:
		Disc.rotation_degrees += Speed
		if !Music.playing:
			Music.playing = true
	else:
		Music.playing = false

func _on_level_pressed() -> void:
	dorotate = !dorotate
