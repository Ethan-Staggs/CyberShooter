extends enemyBase

var droneSpeed = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_tree().get_first_node_in_group("dronePath").progress += droneSpeed * delta
	
func shoot(isPlayerFlipped):
	var randomShots = randf() + 0.2
	canShoot = false
	bullet = preload("res://bullet.tscn").instantiate()
	bullet.initialize(isPlayerFlipped, "drone")
	bullet.global_position = $EnemyAnimatedSprite2D/Marker2D.global_position
	get_tree().root.add_child(bullet)
	gunSound.play()
	
	await get_tree().create_timer(randomShots).timeout
	canShoot = true 
