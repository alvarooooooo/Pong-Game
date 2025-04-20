extends Sprite2D

"""
Score : array, shape = [2]
	Stores the [player, BOT] score.
	
"""
const PADDLE_SPEED : int = 500
var score : Array = [0, 0]
var player : int = 0
var bot : int = 1

func _on_ball_timer_timeout() -> void:
	"""
	Called when ball timer node finishes counting down - when timer emits the timeout() signal
	"""
	$Ball.new_ball()



func _on_score_left_body_entered(body: Node2D) -> void:
	"""
	Called when ball enters left body
	"""
	score[bot] += 1
	$HUD/BOTScore.text = str(score[bot])
	$Ball.new_ball()


func _on_score_right_body_entered(body: Node2D) -> void:
	"""
	Called when ball enters right body
	"""
	score[player] += 1
	$HUD/PlayerScore.text = str(score[player])
	$Ball.new_ball()
