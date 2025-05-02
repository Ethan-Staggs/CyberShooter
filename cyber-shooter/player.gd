extends CharacterBody2D

#@export var Bullet: PackedScene
const SPEED = 100.0
const JUMP_VELOCITY = -345.0
var gravity = 800
var isPlayerFlipped = true
var health = 10


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
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_pressed("left"):
		direction.x -= 1
		$PlayerAnimatedSprite2D.flip_h = false
		isPlayerFlipped = false
		$PlayerAnimatedSprite2D.play("run")
	elif  Input.is_action_pressed("right"):
		direction.x += 1
		$PlayerAnimatedSprite2D.flip_h = true
		isPlayerFlipped = true
		$PlayerAnimatedSprite2D.play("run")
	else:
		$PlayerAnimatedSprite2D.play("idle")
		
	velocity.x = direction.x * SPEED
	move_and_slide()
	
func shoot(isPlayerFlipped):
	var bullet = preload("res://bullet.tscn").instantiate()
	bullet.initialize(isPlayerFlipped, true)
	bullet.global_position = $PlayerAnimatedSprite2D/Marker2D.global_position
	get_tree().root.add_child(bullet)
	
#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.is_in_group("Bullet"):
		#print("Player hit")


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		area.queue_free()
		if health == 1:
			print("Player Dead")
		else:
			health = health - 1
			print("Player hit")
			print(health)
