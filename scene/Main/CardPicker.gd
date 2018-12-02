extends Area2D

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		position = get_viewport().get_mouse_position()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var bodies = get_overlapping_bodies()
		get_node("/root/Main/CardHandler").try_lift_card(bodies)
