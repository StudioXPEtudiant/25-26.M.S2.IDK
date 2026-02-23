extends Node
@export var Camera:Camera2D
@export var t = 0.05
@export var b = Vector2(240, 135)
@export var a = Vector2(240, 135)
var MoveLevel = false

func _on_level_pressed() -> void:
	MoveLevel = true
	
func _process(delta: float) -> void:
	print(Camera.position)
	if MoveLevel == true:
		Camera.position = lerp(Camera.position, b, t)
func _on_back_pressed() -> void:
	MoveLevel = true
