extends RigidBody2D

func _on_Card_body_entered(body):
	var trashcan = get_node("/root/Main/Trashcan")
	if body == trashcan:
		cancel_touches()
		self.queue_free()

func cancel_touches():
	var event = InputEventMouseButton.new()
	event.button_index=BUTTON_LEFT
	event.position = position
	event.pressed = false
	get_tree().input_event(event)