extends CanvasLayer

func updateScore(player, score):
	var scoreLabel = get_node("Banner/HBoxContainer/Player%sScore" %player)
	scoreLabel.text = str(score)

func gameOver(player):
	var label = "Player " + str(player) + " Wins"
	$Popup/NinePatchRect/VBoxContainer/Label.text = label
	$Popup.show()

func _on_Button_pressed():
	get_parent().restartGame()

