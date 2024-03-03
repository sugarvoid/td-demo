extends CharacterBody2D

var max_speed = 300
var speed = 400
var accelaration = 900
var friction = 1000 

var input_direction

func get_input():
	
	return 
	velocity = input_direction * speed

func _process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("jump"):
		$AnimationPlayer.play("jump")

func _physics_process(delta):
	
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	if input_direction == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity += (input_direction * accelaration * delta)
		velocity = velocity.limit_length(max_speed)
	
	move_and_slide()

