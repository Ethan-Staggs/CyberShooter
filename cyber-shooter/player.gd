extends CharacterBody2D

#@export var Bullet: PackedScene
const SPEED = 100.0
const JUMP_VELOCITY = -345.0
var gravity = 800
var isPlayerFlipped = true


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Handle shoot
	if Input.is_action_just_pressed("shoot"):
		$AudioStreamPlayer2D.play()
		shoot(isPlayerFlipped)
		print(isPlayerFlipped)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_pressed("left"):
		direction.x -= 1
		$AnimatedSprite2D.flip_h = false
		isPlayerFlipped = false
		$AnimatedSprite2D.play("run")
	elif  Input.is_action_pressed("right"):
		direction.x += 1
		$AnimatedSprite2D.flip_h = true
		isPlayerFlipped = true
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
		
	velocity.x = direction.x * SPEED
	move_and_slide()
	
func shoot(isPlayerFlipped):
	var bullet = preload("res://bullet.tscn").instantiate()
	bullet.initialize(isPlayerFlipped)
	bullet.global_position = $AnimatedSprite2D/Marker2D.global_position
	get_tree().root.add_child(bullet)
	
