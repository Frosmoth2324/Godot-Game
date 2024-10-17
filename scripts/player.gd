extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -350.0
var sword_damage = 20
var can_sword = true
var can_bow = true
var being_hit = false
var air_jump = false
var cayote_jump = false
var cayote_window = false
var arrow_scene = preload("res://scenes/arrow.tscn")

signal shoot_bow(pos)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = $"."
@onready var animated_sprite = $AnimatedSprite2D
@onready var sword = $Sword
@onready var die_timer = $DieTimer
@onready var collision_shape = $CollisionShape2D
@onready var hit_timer = $HitTimer
@onready var sword_timer = $SwordTimer
@onready var sword_animation = $Sword/SwordAnimation
@onready var cayote_timer = $CayoteTimer
@onready var bow = $Bow
@onready var bow_timer = $BowTimer
@onready var bow_animation = $Bow/BowAnimation
@onready var shoot_from_here_please = $ShootFromHerePlease

func _physics_process(delta):
	player.position = GameManager.player_pos
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if cayote_window == false and cayote_jump == false:
			cayote_timer.start()
			cayote_window = true
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		cayote_jump = true
		
	if Input.is_action_just_pressed("jump") and air_jump == false and GameManager.wings_got and is_on_floor() == false and cayote_jump == true:
		velocity.y = JUMP_VELOCITY
		air_jump = true
		
	if Input.is_action_just_pressed("jump") and cayote_jump == false and is_on_floor() == false:
		velocity.y = JUMP_VELOCITY
		cayote_jump = true
		print("cayote")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
		sword.scale.x = 1
		bow.scale.x = 1
	elif direction < 0:
		animated_sprite.flip_h = true
		sword.scale.x = -1
		bow.scale.x = -1
	if GameManager.health > 0:
		if being_hit == false:
			if is_on_floor():
				if direction == 0:
					animated_sprite.play("idle")
				else:
					animated_sprite.play("run")
			else:
				animated_sprite.play("jump")
		else:
			animated_sprite.play("hit")
	else:
		animated_sprite.play("die")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if GameManager.health > 0:
		move_and_slide()
	GameManager.player_pos = player.position

func _process(_delta):
	if is_on_floor():
		air_jump = false
		cayote_jump = false
		
	if Input.is_action_pressed("sword") and can_sword and GameManager.sword_got:
		print("sword")
		sword_animation.play("swing")
		can_sword = false
		sword_timer.start()
		
	if Input.is_action_pressed("bow") and can_bow and GameManager.bow_got:
		print("bow")
		bow_animation.play("bow")
		can_bow = false
		bow_timer.start()
		shoot_bow.emit(shoot_from_here_please.global_position)
	
func hit(damage):
	if being_hit == false:
		GameManager.health -= damage
		if GameManager.health > 0:
			being_hit = true
			hit_timer.start()
		if GameManager.health <= 0:
			bow_animation.play("RESET")
			sword_animation.play("RESET")
			can_sword = false
			die_timer.start()
			Engine.time_scale = 0.2

func heal(points):
	GameManager.health += points
	if GameManager.health > GameManager.MAX_HP:
		GameManager.health = GameManager.MAX_HP



func _on_die_timer_timeout():
	GameManager.die()

func _on_hit_timer_timeout():
	being_hit = false


func _on_sword_timer_timeout():
	can_sword = true


func _on_hit_box_body_entered(body):
	if body.has_method("hit"):
		body.hit(sword_damage)


func _on_cayote_timer_timeout():
	cayote_jump = true
	cayote_window = false


func _on_bow_timer_timeout():
	can_bow = true



func _on_shoot_bow(pos):
	var arrow = arrow_scene.instantiate() as Area2D
	arrow.position = pos
	if animated_sprite.flip_h == false:
		arrow.direction = Vector2(1,0)
	if animated_sprite.flip_h == true:
		arrow.direction = Vector2(-1,0)
	if animated_sprite.flip_h == true:
		arrow.rotation_degrees = -90
	if animated_sprite.flip_h == false:
		arrow.rotation_degrees = 90
	$Projectiles.add_child(arrow)
