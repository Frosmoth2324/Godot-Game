extends Area2D
var body_is_in = false
var is_closed = true
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var enter_prompt = $EnterPrompt

func _on_body_entered(_body):
	body_is_in = true
	if GameManager.sword_got == false:
		enter_prompt.visible = true


func _on_body_exited(_body):
	body_is_in = false
	enter_prompt.visible = false

func _process(_delta):
	if GameManager.sword_got:
		animated_sprite.play("open")
	if GameManager.sword_got == false and body_is_in:
		if Input.is_action_just_pressed("action"):
			enter_prompt.visible = false
			timer.start()
			animation_player.play("sword")

func _on_timer_timeout():
	GameManager.sword_got = true
	GameManager.key_items += 1
