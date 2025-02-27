extends CanvasLayer

@onready var coin_label = $UI/Layout/CoinCounter/CoinLabel
@onready var health_bar = $UI/Layout/HealthMarker/HealthBar
@onready var wings_sprite = $UI/Layout/VBoxContainer/KeyItems/WingsSprite
@onready var sword_sprite = $UI/Layout/VBoxContainer/KeyItems/SwordSprite
@onready var key_item_lable = $UI/Layout/VBoxContainer/KeyItemLable
@onready var level_indicator = $UI/Layout/LevelIndicator

func _process(_delta):
	coin_label.text = str(GameManager.coins + GameManager.perma_coins)
	health_bar.value = GameManager.health
	health_bar.max_value = GameManager.MAX_HP
	wings_sprite.visible = GameManager.wings_got
	sword_sprite.visible = GameManager.sword_got
	#bow_sprite.visible = GameManager.bow_got
	level_indicator.text = GameManager.on_level
	if GameManager.key_items > 0:
		key_item_lable.visible = true
	level_indicator.visible = get_tree().current_scene.name == "Menu"
