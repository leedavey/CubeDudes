extends Spatial

onready var ballsNode = get_tree().get_root().find_node("Balls", true, false).get_children()

var allBalls
var maxScore = 3
var Player1Score = 0
var Player2Score = 0

func _ready():
	pass

func _on_GoalDetection_body_entered(body, goalId):
	for b in ballsNode:
		b.axis_lock_linear_x = true
		b.axis_lock_linear_y = true
		b.axis_lock_linear_z = true
	get_tree().call_group("players", "canMove", false)
	updateScore(goalId)
	$Timer.start()
	if not $Airhorn.playing:
		$Airhorn.play()

func _on_Timer_timeout():
	get_tree().call_group("players", "canMove", true)	
	for b in ballsNode:
		b.set_translation(Vector3(0,1,0))
		b.axis_lock_linear_x = false
		b.axis_lock_linear_y = false
		b.axis_lock_linear_z = false

func updateScore(player):
	var newScore
	
	if player == 1:
		Player1Score += 1
		newScore = Player1Score
	elif player == 2:
		Player2Score += 1
		newScore = Player2Score
	$GUI.updateScore(player, newScore)
	checkGameOver(newScore, player)

func checkGameOver(newScore, player):
	if newScore == maxScore:
		$Timer.queue_free()
		$GUI.gameOver(player)

func restartGame():
	get_tree().reload_current_scene()


