extends StaticBody2D

var ball_pos : Vector2
var window_height : int
var half_paddle_height : int
var dist : float
var full_move_paddle : int

func _ready() -> void:
	"""
	Called when the node enters the scene tree for the first time
	"""
	window_height = get_viewport_rect().size.y
	half_paddle_height = $ColorRect.get_size().y / 2

func _process(delta: float) -> void:
	"""
	Called every frame
	
	Parameters
	----------
	delta : float
		Time in seconds that has passed since the last frame
	"""
	full_move_paddle = get_parent().PADDLE_SPEED * delta
	ball_pos = $"../Ball".position
	dist = position.y - ball_pos.y
	
	if abs(dist) > full_move_paddle :
		position.y -= full_move_paddle * sign(dist)
	else:
		position.y -= dist

	position.y = clamp(position.y, half_paddle_height, window_height - half_paddle_height)
