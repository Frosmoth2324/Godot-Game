extends CanvasLayer
@onready var control = $Control


func _process(delta):
	control.visible = GameManager.l1_s
