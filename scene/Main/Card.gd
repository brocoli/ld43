extends RigidBody2D

var onTrash = false
var timePenalty
var timeBonus

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
		
		if is_in_group("is_good_card"):
			penalty(cardHandler)
		elif is_in_group("is_bad_card"):
			bonus(cardHandler)
		
		self.queue_free()

func penalty(cardHandler):
	cardHandler.get_node("BadSound").play()
	get_node("/root/Main/DoomsdayClock").time_penalty(timePenalty)
	get_node("/root/Main/ScreenShake").shake_screen()

func bonus(cardHandler):
	cardHandler.get_node("GoodSound").play()
	get_node("/root/Main/DoomsdayClock").time_bonus(timeBonus)
	get_node("/root/Main/JoinJam/Bop").bop()

func _on_Control_gui_input(event):
	if event is InputEventMouseButton: 
		var cardHandler = get_node("/root/Main/CardHandler")
		if event.pressed:
			cardHandler.try_lift_card(self)
		else:
			cardHandler.try_drop_card()
