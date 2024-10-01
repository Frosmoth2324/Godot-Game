extends Control
@onready var save_box = $"Save?"

var player_position

func _on_save_pressed():
	save_box.visible = true

func _on_load_button_down():
	SaveLoader.load_game()
	print("load")

func _on_quit_pressed():
	get_tree().quit()

func _on_play_1_pressed():
	GameManager.perma_coins += GameManager.coins
	GameManager.coins = 0
	GameManager.l1_coins = []
	GameManager.player_pos = Vector2(31,41)
	GameManager.current_level = "res://scenes/level_1.tscn"
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_play_2_pressed():
	GameManager.perma_coins += GameManager.coins
	GameManager.coins = 0
	GameManager.l2_coins = []
	GameManager.player_pos = Vector2(25,-16)
	GameManager.wings_got = true
	GameManager.sword_got = true
	GameManager.key_items = 1
	GameManager.current_level = "res://scenes/level_2.tscn"
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func _on_yes_pressed():
	save_box.visible = false
	SaveLoader.save_game()
	print("save")

func _on_no_pressed():
	save_box.visible = false
