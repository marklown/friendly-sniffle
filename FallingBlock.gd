extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 10
var should_fall = false
var motion = Vector2()

func _physics_process(delta):
	if should_fall:
		motion.y += GRAVITY
		motion = move_and_slide(motion, UP)


func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Player":
		should_fall = true
