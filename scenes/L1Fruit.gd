extends Node

func _ready():
	var collected_fruit = GameManager.l1_fruit
	for fruit in collected_fruit:
		get_node(str(fruit)).queue_free()
