extends Node

var score = 0
var coins = 0
const MAX_HP = 50
var health = MAX_HP
var wings_got = false
var key_items = 0
var tas = false
var l1_s = false

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
		Engine.time_scale = 1
		GameManager.health = GameManager.MAX_HP
		GameManager.score = 0
		GameManager.coins = 0
		tas = false
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
