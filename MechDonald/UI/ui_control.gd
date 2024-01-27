class_name UIControl

extends Control
var player
var xp_label : Label

func _ready():
	xp_label = $MarginContainer/VBoxContainer/XP_Label/Label
	self.player = get_tree().get_nodes_in_group("Player")[0]

func _process(delta):
	xp_label.text = str(player.getXP())
