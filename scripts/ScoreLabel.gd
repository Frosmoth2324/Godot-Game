extends Label

func _process(_delta):
	var score = GameManager.score
	text = "You Got A Score Of " + str(score)
