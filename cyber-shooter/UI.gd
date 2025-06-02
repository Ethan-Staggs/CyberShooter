extends CanvasLayer

@onready var gameOver: Label = $GameOver
@onready var health: Label = $Health
@onready var healthLabel: Label = $HealthLabel
@onready var ammo: Label = $Ammo
@onready var lethals: Label = $Lethals


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.gameOverToggle.connect(toggleGameOver)
	Globals.updateHealth.connect(updateHealth)
	Globals.updateAmmo.connect(updateAmmo)
	Globals.updateLethals.connect(updateLethals)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func toggleGameOver():
	gameOver.visible = !gameOver.visible

func updateHealth(h):
	health.text = str(h)
	
func updateAmmo(a):
	ammo.text = str(a)
	
func updateLethals(l):
	lethals.text = str(l)
	
