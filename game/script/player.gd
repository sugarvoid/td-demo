extends CharacterBody2D

signal request_bullet(pos: Marker2D)
signal landed_on_ground

var max_speed = 300
var speed = 400
var accelaration = 900
var friction = 2000 
var firerate: float = 0.3
var is_reloading: bool = false

var input_direction

func get_input():
	
	return 
	velocity = input_direction * speed

func _process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("jump"):
		$AnimationPlayer.play("jump")
		
	if Input.is_action_pressed("shoot"):
		if !self.is_reloading:
			
			self._fire_gun()

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

func _fire_gun() -> void:
	if $CanFire.is_stopped():
		$CanFire.start(self.firerate)
		self.emit_signal("request_bullet", $Marker2D, self)
