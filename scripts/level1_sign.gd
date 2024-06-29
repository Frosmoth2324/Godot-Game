extends Area2D
var body_is_in = false
@onready var enter_prompt = $EnterPrompt

func _on_body_entered(_body):
	body_is_in = true
	enter_prompt.visible = true


func _on_body_exited(_body):
	body_is_in = false
	enter_prompt.visible = false
	
func _process(_delta):
	if GameManager.l1_s == true and Input.is_action_just_pressed("action"):
			GameManager.l1_s = false
			Engine.time_scale = 1
	elif body_is_in:
		if Input.is_action_just_pressed("action"):
			Engine.time_scale = 0
			GameManager.l1_s = true
