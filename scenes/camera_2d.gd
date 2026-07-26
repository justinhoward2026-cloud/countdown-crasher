extends Camera2D

@export var player: CharacterBody2D

@export var deadzone_x := 120.0
@export var deadzone_y := 80.0

@export var follow_speed := 8.0

@export var look_ahead_distance := 150.0
@export var look_ahead_speed := 6.0

var look_ahead := 0.0
var facing := 1

func _physics_process(delta):

	var target := global_position

	# ---------- LOOK AHEAD ----------
	var player_offset_x = player.global_position.x - global_position.x

	# Only change facing once the player leaves the deadzone
	if player_offset_x > deadzone_x:
		facing = 1
	elif player_offset_x < -deadzone_x:
		facing = -1

	# Smoothly move the look ahead
	look_ahead = lerp(
		look_ahead,
		facing * look_ahead_distance,
		look_ahead_speed * delta
	)

	# ---------- HORIZONTAL ----------
	var target_x = player.global_position.x + look_ahead
	var dx = target_x - global_position.x

	if dx > deadzone_x:
		target.x = player.global_position.x + look_ahead
		target.x = target_x - deadzone_x
	elif dx < -deadzone_x:
		target.x = target_x + deadzone_x

	# ---------- VERTICAL ----------
	var dy = player.global_position.y - global_position.y

	if dy > deadzone_y:
		target.y = player.global_position.y - deadzone_y
	elif dy < -deadzone_y:
		target.y = player.global_position.y + deadzone_y

	# ---------- MOVE CAMERA ----------
	global_position = global_position.lerp(
		target,
		follow_speed * delta
	)
