extends Node
@export var Camera:Camera2D
@export var t = 0.05
@export var b = Vector2(240, -500)
@export var a = Vector2(240, 135)
var MoveLevel = false

func _on_level_pressed() -> void:
	MoveLevel = true
	
func _process(delta: float) -> void:
	if MoveLevel == true:
		Camera.position = lerp(Camera.position, b, t)
	if Camera.position.y - b.y <= 0.1:
		MoveLevel = false
	


func _on_albums_pressed() -> void:
	MoveLevel = true


func _on_settings_pressed() -> void:
	MoveLevel = true


func _on_quit_2_pressed() -> void:
	MoveLevel = true
