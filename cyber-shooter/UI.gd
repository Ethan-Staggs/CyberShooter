extends CanvasLayer

@onready var gameOver: Label = $GameOver
@onready var health: Label = $Health


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.gameOverToggle.connect(toggleGameOver)
	Globals.updateHealth.connect(updateHealth)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func toggleGameOver():
	gameOver.visible = !gameOver.visible

func updateHealth(h):
	health.text = str(h)
	
