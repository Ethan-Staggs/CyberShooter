extends Node2D

@export var speed: float = 500
var bulletDirection = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func initialize(isPlayerFlipped: bool) -> void:
	if isPlayerFlipped == true:
		speed = speed
	else:
		speed = -speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2(speed * delta, 0)
