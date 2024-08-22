extends Area2D

@onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
	GameManager.add_score()
	GameManager.add_coin()
	if get_tree().current_scene.name == "Level 1":
		GameManager.l1_coins.append(get_name())
	elif get_tree().current_scene.name == "Level 2":
		GameManager.l2_coins.append(get_name())
	animation_player.play("pickup")
