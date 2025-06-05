extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#Globals.throw.connect(throw)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	


func _on_grenade_pu_area_entered(area: Area2D) -> void:
	self.queue_free()
	
func throw(direction: Vector2, force: float):
	print("THROOOOW")
	linear_velocity = direction.normalized() * force
