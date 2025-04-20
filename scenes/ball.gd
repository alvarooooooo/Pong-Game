extends CharacterBody2D

const START_SPEED : int = 500
const ACCEL : int = 50
const Y_LIMIT_NEW_BALL : int = 200
var window_size : Vector2
var speed : int
var dir : Vector2
var x_center : int


func _ready() -> void:
	"""
	Called when the node enters the scene tree for the first time
	"""
	window_size = get_viewport_rect().size
	x_center = window_size.x / 2
	speed = START_SPEED
	
func new_ball() -> void:
	"""
	Repositions the ball at the middle on x-axis but randomly at y-axis and random direction
	"""
	position.x = x_center
	position.y = randi_range(Y_LIMIT_NEW_BALL, window_size.y - Y_LIMIT_NEW_BALL)
	speed = START_SPEED
	dir = random_direction()

func random_direction() -> Vector2:
	"""
	Generates a random direction. 
	For x-axis is either left or right (-1, 1)
	For y-axis generates a random float between [-1, 1]
	"""
	var new_dir : Vector2 = Vector2()
	new_dir.x = [-1, 1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()
	
func new_direction(paddle : StaticBody2D ) -> Vector2:
	"""
	Calculates the direction of the ball when collides with paddle
	x-axis:
		reverses direction left or right
	y-axis:
		calculates de distance of the ball and the center of the paddle and divides by half
		the lenght of the paddle. Use cases, the ball hits:
			Center of the paddle: The new y-direction will be horizontal
			Upper area: The new y-direction will be negative (towards the upper)
			Lower area: The new y-direction will be positive (towards the lower)
	"""
	var new_dir : Vector2 = Vector2()
	var dist : float = position.y - paddle.position.y
	
	new_dir.x = -1 if (dir.x > 0) else 1
	new_dir.y = dist / paddle.half_paddle_height
	print(new_dir)
	return new_dir.normalized()
		

func _physics_process(delta: float) -> void:
	"""
	Called at a fixed interval
	
	Parameters
	----------
	delta : float
		Time in seconds that has passed since the last frame
	"""
	var collision = move_and_collide(dir * speed * delta)
	if collision:
		var collider = collision.get_collider()
		if collider == $"../Player" or collider == $"../BOT":
			speed += ACCEL 
			dir = new_direction(collider)
		elif collider == $"../Borders":
			dir = dir.bounce(collision.get_normal())
