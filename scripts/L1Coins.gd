extends Node

func _ready():
	var collected_coins = GameManager.l1_coins
	for coin in collected_coins:
		get_node(str(coin)).queue_free()
