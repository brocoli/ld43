extends TextureButton

func _on_JoinJam_pressed():
	get_tree().change_scene("res://scene/Endgame/JoinJam.tscn")

func check_no_bad_cards(lastCard):
	var badCards = get_tree().get_nodes_in_group("is_bad_card")
	badCards.erase(lastCard)
	if badCards.size() == 0:
		disabled = false
