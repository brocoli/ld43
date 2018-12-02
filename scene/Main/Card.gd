extends RigidBody2D

var onTrash = false

func _process(delta):
	if onTrash:
		try_throw_card_away()

func handle_hover_into_trash(trashcan):
	onTrash = true
	try_throw_card_away()

func handle_hover_out_of_trash(trashcan):
	onTrash = false

func try_throw_card_away():
	var cardHandler = get_node("/root/Main/CardHandler")
	if cardHandler.focusedCard == null:
		var joinJamButton = get_node("/root/Main/JoinJam")
		joinJamButton.check_no_bad_cards(self)
		
		self.queue_free()
		get_node("/root/Main/ScreenShake").shake_screen()