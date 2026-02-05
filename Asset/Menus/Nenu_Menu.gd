extends Node
@export var Camera:Camera2D
var t = 240.-120
var b = 240.-90
var a = 240.135

func _on_level_pressed(delta) -> void:
	t += delta * 0.4

	Camera.position = a.position.lerp(b.position, t)
