extends Label

var score = 0

func _process(delta):
score += 1
text = str(score)
