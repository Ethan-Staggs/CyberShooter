extends enemyBase


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var isPlayerFlipped = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._physics_process(delta)
	

	
