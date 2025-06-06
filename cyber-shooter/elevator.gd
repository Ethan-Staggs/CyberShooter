extends StaticBody2D

var elevatorSpeed = 30
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().get_first_node_in_group("elevatorPath").progress += elevatorSpeed * delta
