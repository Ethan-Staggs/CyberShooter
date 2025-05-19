extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if flip_h:
		$Marker2D.position = Vector2(-17, $Marker2D.position.y)
	else:
		$Marker2D.position = Vector2(17, $Marker2D.position.y)
