extends CharacterBody2D

@onready var cam: Camera2D = $Camera2D
@onready var marker: Marker2D = $PlayerAnimatedSprite2D/Marker2D

const SPEED = 200.0
const JUMP_VELOCITY = -365.0
var gravity = 300
var isPlayerFlipped = false
var health = 15
var dead = false
var isJumping = false
var pistolAnimation = false
var ammo = 30
var lethals = 0
var canShoot = false

func _ready() -> void:
	cam.enabled = true
	Globals.pistolAreaEntered.connect(onPistolAreaEntered)
	Globals.grenadeAreaEntered.connect(onGrenadeAreaEntered)
	Globals.ammoAreaEntered.connect(onAmmoAreaEntered)
	Globals.updateHealth.connect(onHealthPickupEntered)
	
func _physics_process(delta: float) -> void:
 
	if !dead:
		movement(delta)
		
func movement(delta: float) -> void:
 
	if !dead:
		#if Input.is_action_just_pressed("throw"):
			#Globals.throw.emit(5.5, 5.5, 100)
		
		var direction = Input.get_vector("left", "right", "up", "down")
		
		if not is_on_floor():
			velocity += get_gravity() * delta
			velocity.x = Input.get_axis("left", "right") * SPEED
		
		if Input.is_action_just_pressed("shoot"):
			
			if !ammo < 0 and canShoot:
				$AudioStreamPlayer2D.play()
				ammo -= 1
				Globals.updateAmmo.emit(ammo)
				shoot(isPlayerFlipped)
			
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			$PlayerAnimatedSprite2D.play("jumping")
			isJumping = true
			
		elif is_on_floor():
			isJumping = false
		
		velocity.x = direction.x * SPEED
		
		if isJumping:
			if !pistolAnimation:
				$PlayerAnimatedSprite2D.play("unarmedJumping")
			elif pistolAnimation:
				$PlayerAnimatedSprite2D.play("armedjumping")
		elif Input.is_action_pressed("left"):
			print(velocity.x)
			direction.x -= 1
			$PlayerAnimatedSprite2D.flip_h = false
			isPlayerFlipped = false
			isJumping = false
			if !pistolAnimation:
				$PlayerAnimatedSprite2D.play("unarmedRun")
			elif pistolAnimation:
				$PlayerAnimatedSprite2D.play("armedRun")
		elif  Input.is_action_pressed("right"):
			direction.x += 1
			$PlayerAnimatedSprite2D.flip_h = true
			isPlayerFlipped = true
			isJumping = false
			if !pistolAnimation:
				$PlayerAnimatedSprite2D.play("unarmedRun")
			elif pistolAnimation:
				$PlayerAnimatedSprite2D.play("armedRun")
		else:
			isJumping = false
			if !pistolAnimation:
				$PlayerAnimatedSprite2D.play("unarmedIdle")
			elif pistolAnimation:
				$PlayerAnimatedSprite2D.position.y = 0.6
				$PlayerAnimatedSprite2D.play("armedIdle")
			
	move_and_slide()
	
func shoot(isPlayerFlipped):
	var bullet = preload("res://bullet_to_enemy.tscn").instantiate()
	bullet.initialize(isPlayerFlipped, true)
	bullet.global_position = $PlayerAnimatedSprite2D/Marker2D.global_position
	get_tree().root.add_child(bullet)
	
#Handle enemy being shot
func _on_area_2d_area_entered(area: Area2D) -> void:
	#if bullet is from an enemy gun
	if area.is_in_group("BulletToPlayer"):
		area.queue_free()
		health = health - 1
		Globals.updateHealth.emit(health)
		onPistolAreaEntered
		if health < 1:
			dead = true
			Globals.gameOverToggle.emit()
			#if bullet is from player gun
		elif area.is_in_group("BulletToEnemy"):
			health = health
		#elif area.is_in_group("Pistol"):
			#print("in group")
			
#Pick up pistol when walking over pistol
func onPistolAreaEntered():
	canShoot = true
	pistolAnimation = true

#Pick up grenade when walking over grenade
func onGrenadeAreaEntered():
	lethals = lethals + 1
	Globals.updateLethals.emit(lethals)
	
#Pick up ammo when walking over ammo
func onAmmoAreaEntered():
	ammo = ammo + 12
	Globals.updateAmmo.emit(ammo)
	
#Pick up health when walking over health
func onHealthPickupEntered():
	health = health + 1
	Globals.updateHealth.emit(health)
