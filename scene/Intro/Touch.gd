extends Control

var currentChild = 1

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		currentChild += 1
		if currentChild > 3:
			get_tree().change_scene("res://scene/Main/Main.tscn")
		else:
			get_node(String(currentChild)).visible = true