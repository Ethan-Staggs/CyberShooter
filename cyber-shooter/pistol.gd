extends Area2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var marker = player.get_node("PlayerAnimatedSprite2D/Marker2D")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if marker:
		global_position = marker.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	print("Move pistol location to marker2d node on player hand")
	print(marker.position)
	
	
