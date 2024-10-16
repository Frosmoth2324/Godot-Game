extends Area2D

@export var speed: int = 230
var direction: Vector2 = Vector2.UP
var arrow_damage = 10

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	if body.has_method("hit"):
		body.hit(arrow_damage)
		queue_free()
	else:
		queue_free()
