extends Node



func save_game(place = "user://savegame.json"):
	var file = FileAccess.open(place, FileAccess.WRITE)
	var save_data = {}
	save_data["player_pos:x"] = GameManager.player_pos.x
	save_data["player_pos:y"] = GameManager.player_pos.y
	save_data["score"] = GameManager.score
	save_data["coins"] = GameManager.coins
	save_data["health"] = GameManager.health
	save_data["wings_got"] = GameManager.wings_got
	save_data["sword_got"] = GameManager.sword_got
	save_data["key_items"] = GameManager.key_items
	save_data["tas"] = GameManager.tas
	save_data["current_level"] = GameManager.current_level
	save_data["perma_coins"] = GameManager.perma_coins
	
	save_data["l1_coins"] = GameManager.l1_coins
	save_data["l2_coins"] = GameManager.l2_coins
	save_data["l1_fruit"] = GameManager.l1_fruit
	save_data["l2_fruit"] = GameManager.l2_fruit
	save_data["l1_enemy"] = GameManager.l1_enemy
	save_data["l2_enemy"] = GameManager.l2_enemy
	
	var json = JSON.stringify(save_data)
	file.store_string(json)
	file.close()
	
	
func load_game(place = "user://savegame.json"):
	var file = FileAccess.open(place, FileAccess.READ)
	var json = file.get_as_text()
	var save_data = JSON.parse_string(json)
	GameManager.player_pos.x = save_data["player_pos:x"]
	GameManager.player_pos.y = save_data["player_pos:y"]
	GameManager.score = save_data["score"]
	GameManager.coins = save_data["coins"]
	GameManager.health = save_data["health"]
	GameManager.wings_got = save_data["wings_got"]
	GameManager.sword_got = save_data["sword_got"]
	GameManager.key_items = save_data["key_items"]
	GameManager.tas = save_data["tas"]
	GameManager.current_level = save_data["current_level"]
	GameManager.l1_coins = save_data["l1_coins"]
	GameManager.l2_coins = save_data["l2_coins"]
	GameManager.l1_fruit = save_data["l1_fruit"]
	GameManager.l2_fruit = save_data["l2_fruit"]
	GameManager.l1_enemy = save_data["l1_enemy"]
	GameManager.l2_enemy = save_data["l2_enemy"]
	GameManager.perma_coins = save_data["perma_coins"]
	file.close()
	get_tree().change_scene_to_file(GameManager.current_level)
