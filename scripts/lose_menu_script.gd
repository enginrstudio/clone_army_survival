extends Control

@export var restart_button: Button
@export var quit_button: Button


func _ready() -> void:
	restart_button.pressed.connect(
		Callable(
			self,
			"_handle_restart_clicked"
		))
	quit_button.pressed.connect(
		Callable(
			self,
			"_handle_quit_clicked"
		))

func _handle_restart_clicked():
	get_tree().change_scene_to_file("res://game_scenes/game.tscn")

func _handle_quit_clicked():
	get_tree().quit()