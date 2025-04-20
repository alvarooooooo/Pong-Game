extends StaticBody2D

var window_height : int
var half_paddle_height : int

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
	if Input.is_action_pressed("ui_up"):
		position.y -= get_parent().PADDLE_SPEED * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += get_parent().PADDLE_SPEED * delta
	position.y = clamp(position.y, half_paddle_height, window_height - half_paddle_height)
	
