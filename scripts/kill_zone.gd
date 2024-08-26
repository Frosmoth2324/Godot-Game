extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	print("You Died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()



func _on_timer_timeout():
	Engine.time_scale = 1
	GameManager.health = GameManager.MAX_HP
	GameManager.score = 0
	GameManager.coins = 0
	GameManager.l1_coins = []
	GameManager.l2_coins = []
	GameManager.l1_enemy = []
	GameManager.l2_enemy = []
	GameManager.l1_fruit = []
	GameManager.l2_fruit = []
	if get_tree().current_scene.name == "Level 1":
		GameManager.player_pos = Vector2(31,41)
	elif get_tree().current_scene.name == "Level 2":
		GameManager.player_pos = Vector2(25,-16)
	get_tree().reload_current_scene()
