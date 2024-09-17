extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -350.0
var sword_damage = 10
var can_sword = true
var being_hit = false
var air_jump = false
var cayote_jump = false
var cayote_window = false
var sword_scale = 1

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
		sword.scale.x = sword_scale
	elif direction < 0:
		animated_sprite.flip_h = true
		sword.scale.x = -sword_scale
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
		
	if Input.is_action_pressed("attack") and can_sword and GameManager.sword_got:
		print("sword")
		sword_animation.play("swing")
		can_sword = false
		sword_timer.start()
	
func hit(damage):
	if being_hit == false:
		GameManager.health -= damage
		if GameManager.health > 0:
			being_hit = true
			hit_timer.start()
		if GameManager.health <= 0:
			sword_animation.play("RESET")
			can_sword = false
			die_timer.start()
			Engine.time_scale = 0.2

func heal(points):
	GameManager.health += points
	if GameManager.health > GameManager.MAX_HP:
		GameManager.health = GameManager.MAX_HP



func _on_die_timer_timeout():
	Engine.time_scale = 1
	GameManager.health = GameManager.MAX_HP
	GameManager.score = 0
	GameManager.coins = 0
	if get_tree().current_scene.name == "Level 1":
		GameManager.player_pos = Vector2(31,41)
	elif get_tree().current_scene.name == "Level 2":
		GameManager.player_pos = Vector2(25,-16)
	get_tree().reload_current_scene()


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
