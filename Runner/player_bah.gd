extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 5

var target_velocity = Vector3.ZERO

@warning_ignore("unused_parameter")
func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("move_right"):
		direction.z -= 1
	if Input.is_action_pressed("move_left"):
		direction.z += 1

	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Moving the Character
	velocity = target_velocity
	move_and_slide()
