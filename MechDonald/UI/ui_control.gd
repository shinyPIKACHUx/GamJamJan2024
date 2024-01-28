class_name UIControl

extends Control
var player
var xp_label : Label
@onready var health_bar = $MarginContainer/VBoxContainer/HealthBar as ProgressBar

func _ready():
	xp_label = $MarginContainer/VBoxContainer/XP_Label/Label
	self.player = get_tree().get_nodes_in_group("Player")[0]
	
func _process(delta):
	#Potential Optimization for Performance
	xp_label.text = "EXP:   " + str(player.getXP())
	health_bar.value = player.getHP()
