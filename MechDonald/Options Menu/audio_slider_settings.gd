extends Control

@onready var audio_name_lbl = $HBoxContainer/Audio_Name_Lbl as Label
@onready var audio_num_lbl = $HBoxContainer/Audio_Num_Lbl as Label
@onready var h_slider = $HBoxContainer/HSlider as HSlider

@export_enum("Master", "Music", "Effects", "Noise", "Voices") var bus_name : String

var bus_index : float = 0
func _ready():

	get_bus_name_by_index()
	set_name_label_text()
	set_slider_value()
	set_audio_num_label_text()
	h_slider.value_changed.connect(on_value_changed)
	
func set_name_label_text() -> void:
	audio_name_lbl.text = str(bus_name) + " Volume"
	
	
func set_audio_num_label_text() -> void:
	audio_num_lbl.text = str(h_slider.value * 100)
	
func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	
func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_effect(bus_index, 0).get_volume_db())
	
func on_value_changed(value : float) -> void:
	AudioServer.get_bus_effect(bus_index, 0).set_volume_db(linear_to_db(value))
	set_audio_num_label_text()


