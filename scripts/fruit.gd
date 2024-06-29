extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var player = %Player

func _on_body_entered(_body):
	player.heal(10)
	GameManager.add_score()
	animation_player.play("pickup")
