extends Node

var score = 0
var coins = 0
var perma_coins = 0
const MAX_HP = 50
var health = MAX_HP
var player_pos: Vector2
var wings_got = false
var sword_got = false
var bow_got = true
var key_items = 0
var tas = false
var l1_s = false
var on_level = "New Game"
var current_level = "res://scenes/menu.tscn"

var l1_coins = []
var l2_coins = []

var l1_fruit = []
var l2_fruit = []

var l1_enemy = []
var l2_enemy = []

func add_score():
	score += 1
func add_coin():
	coins += 1
	
func _process(_delta):
	if Input.is_action_just_pressed("tas"):
		if tas:
			Engine.time_scale = 1
			tas = false
		else:
			Engine.time_scale = 0.3
			tas = true
	if Input.is_action_just_pressed("pause"):
		if get_tree().current_scene.name == "Menu":
			SaveLoader.load_game("user://pausegame.json")
		else:
			SaveLoader.save_game("user://pausegame.json")
			on_level = get_tree().current_scene.name
			get_tree().change_scene_to_file("res://scenes/menu.tscn")
