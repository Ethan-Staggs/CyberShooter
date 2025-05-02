extends Node2D

@export var shootFromDist = 310
var calcPosition = 0.0
var isPlayerFlipped = false
var canShoot = true
var health = 10
var bullet

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		var player_position = player.global_position.x
		calcPosition = $EnemyAnimatedSprite2D.global_position.x - player_position
	
	if calcPosition < shootFromDist and canShoot and calcPosition > -325:
		shoot(isPlayerFlipped)
	if calcPosition < shootFromDist:
		$EnemyAnimatedSprite2D.play("shoot")
	else:
		$EnemyAnimatedSprite2D.play("idle")
		
	if  calcPosition < 0:
		isPlayerFlipped = false
		$EnemyAnimatedSprite2D.flip_h = false
	else:
		isPlayerFlipped = true
		$EnemyAnimatedSprite2D.flip_h = true
		
func shoot(isPlayerFlipped):
	canShoot = false
	bullet = preload("res://bullet.tscn").instantiate()
	bullet.initialize(isPlayerFlipped, false)
	bullet.global_position = $EnemyAnimatedSprite2D/Marker2D.global_position
	get_tree().root.add_child(bullet)
	print("pew")
	
	await get_tree().create_timer(0.5).timeout
	canShoot = true 
	
		
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Bullet"):
		area.queue_free()
		if health == 1:
			print("Enemy Dead")
			queue_free()
		else:
			health = health - 1
			print("Enemy hit")
			print(health)
