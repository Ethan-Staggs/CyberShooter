extends Area2D

var entered = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

signal pistolAreaEntered

func _on_area_entered(area: Area2D) -> void:
	print("In area", area)
	self.queue_free()
	Globals.emit_signal("pistolAreaEntered")
	
	
	
	
