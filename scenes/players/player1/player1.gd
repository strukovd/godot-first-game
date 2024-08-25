extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Прыжок
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		# движение (ходьба)
		velocity.x = direction * SPEED
		if velocity.y == 0: # Если не падает
			anim.play("run")
	else:
		# бездействие
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0: # Если не падает
			anim.play("idle");

# анимация падения
	if direction == -1:
		$AnimatedSprite2D.flip_h = true;
	elif direction == 1:
		$AnimatedSprite2D.flip_h = false;
		
	if velocity.y > 0:
		anim.play("fall")

	move_and_slide()
