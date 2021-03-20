extends KinematicBody2D
class_name Player


var speed = 100

func _physics_process(delta):
	var vel = Vector2()
	if Input.is_action_pressed("player_down"):
		vel.y += 1
	elif Input.is_action_pressed("player_up"):
		vel.y -= 1
	if Input.is_action_pressed("player_left"):
		vel.x -= 1
	elif Input.is_action_pressed("player_right"):
		vel.x += 1

	vel = vel.normalized() * speed
	position += vel * delta
	look_at(get_global_mouse_position())
