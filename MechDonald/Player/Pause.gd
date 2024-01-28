extends Control
@onready var resume = $MarginContainer/PauseBackground/MarginContainer/VBoxContainer/Resume as Button
@onready var exit_to_menu = $"MarginContainer/PauseBackground/MarginContainer/VBoxContainer/Exit to Menu" as Button

func _input(event):
	if event.is_action_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		

func _on_resume_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state


func _on_exit_to_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MainMenu/MainMenu.tscn")

