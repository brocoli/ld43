extends Area2D

func _on_Trashcan_body_entered(body):
	if body.is_in_group("is_card"):
		body.handle_hover_into_trash(self)

func _on_Trashcan_body_exited(body):
	if body.is_in_group("is_card"):
		body.handle_hover_out_of_trash(self)
