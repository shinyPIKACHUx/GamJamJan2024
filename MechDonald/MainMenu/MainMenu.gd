#Main and Options Menu code from User CoffeeCrow on Youtube https://www.youtube.com/playlist?list=PLhBqFleCVBkXQiE8Nm4Co_1iJJ4L7UIzr

class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/StartButton as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/ExitButton as Button
@onready var options_buton = $MarginContainer/HBoxContainer/VBoxContainer/Options_Buton as Button
@onready var options_menu = $Options_Menu as OptionsMenu
@onready var margin_container = $MarginContainer as MarginContainer
@onready var start_level = preload("res://Levels/Level 1.tscn") as PackedScene

func _ready():
	handle_connecting_signals()
	print("Help")

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true
func on_exit_pressed() -> void:
		get_tree().quit()

func on_exit_options_menu() -> void:
		margin_container.visible = true
		options_menu.visible = false
		
		
func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_pressed)
	options_buton.button_down.connect(on_options_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)

