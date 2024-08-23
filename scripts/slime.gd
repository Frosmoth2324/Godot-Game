extends CharacterBody2D

const SPEED = 60
var direction = 1
var health = 10
var being_hit = false

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var hit_timer = $HitTimer
@onready var die_timer = $DieTimer
@onready var hit_box = $AnimatedSprite2D/HitBox

func _process(delta):
	
	if health <=0:
		animated_sprite.play("die")
	elif being_hit == true:
		animated_sprite.play("hit")
	else:
		animated_sprite.play("idle")
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	if health > 0 or being_hit == false:
		position.x += direction * SPEED * delta
	
func hit(damage):
	if being_hit == false:
		health -= damage
		if health > 0:
			being_hit = true
			hit_timer.start()
		if health <= 0:
			hit_box.queue_free()
			die_timer.start()


func _on_hit_box_body_entered(body):
	if body.has_method("hit"):
		body.hit(10)


func _on_hit_timer_timeout():
	being_hit = false


func _on_die_timer_timeout():
	if get_tree().current_scene.name == "Level 1":
		GameManager.l1_enemy.append(get_name())
	elif get_tree().current_scene.name == "Level 2":
		GameManager.l2_enemy.append(get_name())
	queue_free()
