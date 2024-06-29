extends Node2D

@onready var sword = $"."
var is_swording

func _on_player_sword_swing():
	print("swung")
	sword.visible = true
	is_swording = true
	


func _on_sword_timer_timeout():
	sword.visible = false
	is_swording = false
