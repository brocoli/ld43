extends Node

func _on_Join_Jam_pressed():
	get_tree().change_scene("res://scene/JoinJam.tscn")

func _on_TextureButton_pressed():
	get_tree().change_scene("res://scene/BailOut.tscn")
