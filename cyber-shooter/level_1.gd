extends Node2D


@onready var spawnPoint: Marker2D = $Marker2D 
var player
var droneSpeed = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnPlayer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	 if player.dead:
		if Input.is_action_just_pressed("restart"):
			get_tree().get_first_node_in_group("Player").queue_free()
			spawnPlayer()
			
func spawnPlayer():
	player = preload("res://player.tscn").instantiate()
	player.global_position = spawnPoint.global_position
	Globals.gameOverToggle.emit()
	get_tree().root.add_child.call_deferred(player)
	
