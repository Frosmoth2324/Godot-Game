extends Node

func _ready():
	var killed_enemies = GameManager.l1_enemy
	for enemy in killed_enemies:
		get_node(str(enemy)).queue_free()
