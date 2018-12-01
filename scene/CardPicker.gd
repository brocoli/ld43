extends Area2D

func _input(event):
	if event is InputEventMouseButton:
		var bodies = get_overlapping_bodies()
		get_node("/root/Main/CardHandler").try_lift_card(bodies)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		position = get_viewport().get_mouse_position()
