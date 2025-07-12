extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += 0.5 * get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0:
		animated_sprite.play("run")
		animated_sprite.flip_h = direction < 0
		velocity.x = direction * SPEED
		Signals.player_moves.emit(direction, delta)
	else:
		animated_sprite.play("idle")
		velocity.x = 0
		Signals.player_moves.emit(direction, delta)
		
	velocity += get_gravity() * delta
	move_and_slide()
	

	move_and_slide()
