extends Node

func _on_level_pressed() -> void:
	get_tree().change_scene_to_file("res://asset/Menus/MainMenu.tscn")
