extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var player = %Player

func _on_body_entered(_body):
	player.heal(10)
	GameManager.add_score()
	if get_tree().current_scene.name == "Level 1":
		GameManager.l1_fruit.append(get_name())
	elif get_tree().current_scene.name == "Level 2":
		GameManager.l2_fruit.append(get_name())
	animation_player.play("pickup")
