extends Node2D

@export var speed: float = 500
var bulletDirection = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func initialize(isPlayerFlipped: bool, isPlayer: bool) -> void:
	
	#if player is flipped and player is calling
	if isPlayerFlipped == true and isPlayer == true:
		speed = speed
		
		#if player is NOT flipped and player is calling
	elif isPlayerFlipped == false and isPlayer == true:
		speed = -speed
		
		#if enemy is flipped and enemy is calling
	elif isPlayerFlipped == true and isPlayer == false:
		$AnimatedSprite2D.modulate = Color(214,54,0)
		speed = -speed
		
		#if enemy is NOT flipped and enemy is calling
	elif isPlayerFlipped == false and isPlayer == false:
		$AnimatedSprite2D.modulate = Color(214,54,0)
		speed = speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(speed * delta, 0)
