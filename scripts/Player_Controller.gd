extends CharacterBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var upper_body: Sprite2D = $upper_body
@onready var head: Sprite2D = $head
@onready var arms: Sprite2D = $arms
@onready var lower_body: Sprite2D = $lower_body


const SPEED := 180.0
const ACCELERATION := 800
const JUMP_VELOCITY := -450.0
const FRICTION := 1000
const GRAVITY := 1000
const FALL_GRAVITY := 3000

func handle_animation(direction : float):
	if direction:
		arms.flip_h = direction < 0
		upper_body.flip_h = direction < 0
		head.flip_h = direction < 0
		lower_body.flip_h = direction < 0
	else:
		animation_player.play("idle")
	if not is_on_floor():
		animation_player.play("idle")

func grab_gravity(velo: Vector2):
	if velo.y < 0:
		return GRAVITY
	return FALL_GRAVITY

func _physics_process(delta: float) -> void:
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
		
	handle_animation(direction)
	move_and_slide()
