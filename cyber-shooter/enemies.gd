extends Node2D
class_name enemyBase

@export var shootFromDist = 310
@onready var gunSound = $gunSound
@onready var deathSoundPlayer = $deathSound
var calcPosition = 0.0
var isPlayerFlipped = false
var canShoot = true
var health = 6
var bullet
var dropPlayerHealthPowerup



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta: float) -> void:
	
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		var player_position = player.global_position.x
		calcPosition = $EnemyAnimatedSprite2D.global_position.x - player_position
	
	if calcPosition < shootFromDist and canShoot and calcPosition > -325 and health > 1:
		shoot(isPlayerFlipped)
	if calcPosition < shootFromDist and health > 1:
		$EnemyAnimatedSprite2D.play("shoot")
	elif calcPosition > shootFromDist and health > 1:
		$EnemyAnimatedSprite2D.play("idle")
		
	if  calcPosition < 0 and health > 1:
		isPlayerFlipped = false
		$EnemyAnimatedSprite2D.flip_h = false
	elif calcPosition > 0 and health > 1:
		isPlayerFlipped = true
		$EnemyAnimatedSprite2D.flip_h = true
		
func shoot(isPlayerFlipped):
	var randomShots = randf() + 0.2
	canShoot = false
	bullet = preload("res://bullet.tscn").instantiate()
	bullet.initialize(isPlayerFlipped, "false")
	bullet.global_position = $EnemyAnimatedSprite2D/Marker2D.global_position
	get_tree().root.add_child(bullet)
	gunSound.play()
	
	await get_tree().create_timer(randomShots).timeout
	canShoot = true 
	
		
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("BulletToEnemy"):
		area.queue_free()
	if health <= 1:
		$EnemyAnimatedSprite2D.play("dead")
		deathSoundPlayer.play()
		dropPlayerHealthPowerup = preload("res://health_pickup.tscn").instantiate()
		dropPlayerHealthPowerup.global_position = global_position
		get_tree().get_root().add_child(dropPlayerHealthPowerup)
		await get_tree().create_timer(1.5).timeout
		queue_free()
	elif area.is_in_group("BulletToPlayer"):
		health = health
	else:
		health = health - 1
		
	
		
		

	
