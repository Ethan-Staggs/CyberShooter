extends Node2D

var calcPosition = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print($AnimatedSprite2D.global_position.x)
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		var player_position = player.global_position.x
		calcPosition = $AnimatedSprite2D.global_position.x - player_position
		print(calcPosition)
	if calcPosition < 250:
		print("shoot")
		$AnimatedSprite2D.play("shoot")
	else:
		$AnimatedSprite2D.play("idle")
		
		
		
	
	
