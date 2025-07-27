extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const FALL_SPEED = 2500
const JUMP_GRAVITY = 800
const WALL_SLIDE_SPEED = 50
const WALL_JUMP_PUSHBACK = 1000

var was_on_floor = 0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $Coyote_timer
@onready var buffer_time: Timer = $Buffer_time

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("move_left", "move_right")
	handle_gravity(delta, direction)
	handle_jump()
	handle_wall_jump(direction)
	animation_player(direction)
	apply_movement(direction, SPEED, delta)
	was_on_floor = is_on_floor()
	move_and_slide()
	
func die():
	pass
	
func jump():
	velocity.y = JUMP_VELOCITY
	coyote_timer.stop()
	buffer_time.stop()
	
func apply_movement(dir, speedy, delta):
	if dir != 0:
		velocity.x = dir * SPEED
		Signals.player_moves.emit(dir, speedy, delta)
	else:
		velocity.x = 0
		Signals.player_moves.emit(dir, speedy, delta)
	
func animation_player(dir):
	if dir != 0:
		animated_sprite.play("run")
		animated_sprite.flip_h = dir < 0
	else:
		animated_sprite.play("idle")
	
func handle_jump():
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
		
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		else:
			buffer_time.start()
			
	if !buffer_time.is_stopped() and (is_on_floor() or !coyote_timer.is_stopped()):
		jump()
		
func handle_wall_jump(dir):
	if Input.is_action_just_pressed("jump"):
		if is_on_wall():
			walljump()
		else:
			buffer_time.start()
			
	if !buffer_time.is_stopped() and is_on_wall():
		walljump()
	
func walljump():
	if Input.is_action_pressed("move_right"):
		velocity.x = - WALL_JUMP_PUSHBACK
	if Input.is_action_pressed("move_left"):
		velocity.x = WALL_JUMP_PUSHBACK
	velocity.y = JUMP_VELOCITY
	buffer_time.stop()
	
func handle_gravity(delta, dir):
	if !is_on_floor():
		if velocity.y < 0:
			velocity.y += JUMP_GRAVITY * delta
		else:
			if is_on_wall() and dir != 0:
				velocity.y = WALL_SLIDE_SPEED
			else:
				velocity.y += FALL_SPEED * delta
