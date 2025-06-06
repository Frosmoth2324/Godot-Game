extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	print("You Died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout():
	GameManager.die()
