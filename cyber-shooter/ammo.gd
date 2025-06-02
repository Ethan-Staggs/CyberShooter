extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
signal ammoAreaEntered


func _on_area_entered(area: Area2D) -> void:
	print("Ammo collected")
	self.queue_free()
	Globals.emit_signal("updateAmmo")
	Globals.emit_signal("ammoAreaEntered")
