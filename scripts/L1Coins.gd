extends Node

func _ready():
	var collected_coins = GameManager.l1_coins
	for coin in collected_coins:
		coin.queue_free()
