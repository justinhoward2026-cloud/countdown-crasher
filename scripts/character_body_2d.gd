extends CharacterBody2D


const SPEED := 180.0
const ACCELERATION := 800
const JUMP_VELOCITY := -450.0
const FRICTION := 1000
const GRAVITY := 1000
const FALL_GRAVITY := 3000

func grab_gravity(velo: Vector2):
	if velo.y < 0:
		return GRAVITY
	return FALL_GRAVITY

func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += grab_gravity(velocity) * delta
	if Input.is_action_just_released("Jump") and velocity.y < 0:
		velocity.y = JUMP_VELOCITY / 4
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else: 
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	move_and_slide()
