extends CanvasLayer
@onready var control = $Control


func _process(_delta):
	control.visible = GameManager.l1_s
