extends Control

var player_position

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/level1.tscn")


func _on_save_pressed():
	print("save")


func _on_load_button_down():
	print("load")


func _on_quit_pressed():
	get_tree().quit()


func _on_button_pressed():
	GameManager.wings_got = true
	GameManager.key_items = 1
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")
