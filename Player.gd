extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 40
const ACC = 75
const MAX_SPEED = 300
const JUMP_HEIGHT = 800

var motion = Vector2()

var lives = 3

signal life_lost
signal player_fell_off_map


func _physics_process(delta):
	
	var friction = false
	
	motion.y += GRAVITY
	
	# walking
	if Input.is_action_pressed("move_right"):
		motion.x = min(motion.x + ACC, MAX_SPEED)
	elif Input.is_action_pressed("move_left"):
		motion.x = max(motion.x - ACC, -MAX_SPEED)
	else:
		friction = true

		
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, .25)
	else:
		if friction:
			motion.x = lerp(motion.x, 0, .10)
	
	motion = move_and_slide(motion, UP)
	
	if position.y > 608+32:
		emit_signal('player_fell_off_map')
	

func hit():
	hide()
	$CollisionShape2D.disabled = true

