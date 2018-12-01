extends RigidBody2D

func _on_Card_body_entered(body):
	var trashcan = get_node("/root/Main/Trashcan")
	if body == trashcan:
		self.queue_free()
