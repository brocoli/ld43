extends Node

export (PackedScene) var Card
export (PackedScene) var TouchDragPhysics
export (int) var amountGoodCards
export (int) var amountBadCards
export (float) var radiusX
export (float) var radiusY
export (float) var timePenalty
export (float) var timeBonus

export (String) var targetTheme

var focusedCard
var draggableBody

var amtGood
var amtBad

var sortedGameIdeas

func _ready():
	seed(OS.get_unix_time())
	
	var gameIdeasFile = File.new()
	gameIdeasFile.open("res://texts/gameIdeas.json", gameIdeasFile.READ)
	var gameIdeasText = gameIdeasFile.get_as_text()
	gameIdeasFile.close()
	
	var gameIdeas = parse_json(gameIdeasText)
	sortedGameIdeas = sort_game_ideas(gameIdeas)

	spawn_cards()

func sort_game_ideas(gameIdeas):
	var sortedGood = []
	var sortedBad = []
	
	for theme in gameIdeas:
		var ideas = gameIdeas[theme]
		if theme == targetTheme:
			for idea in ideas:
				sortedGood.append(idea)
		else:
			for idea in ideas:
				sortedBad.append(idea)
	
	return {
		"good": sortedGood,
		"bad": sortedBad,
	}

func spawn_cards():
	amtGood = min(amountGoodCards, sortedGameIdeas["good"].size())
	amtBad = min(amountBadCards, sortedGameIdeas["bad"].size())
	
	for i in range(amtGood + amtBad):
		spawn_card(i)

func spawn_card(i):
	var distanceX = rand_range(0, radiusX)
	var distanceY = rand_range(0, radiusY)
	var angle = rand_range(0, 2*PI)
	var pos = Vector2(distanceX*cos(angle), distanceY*sin(angle))
	
	var rot = rand_range(0, 2*PI)
	
	var card = Card.instance()
	card.position = pos
	card.rotation = rot
	card.z_index = i
	
	card.timePenalty = timePenalty
	card.timeBonus = timeBonus
	
	set_card_good_or_bad(card)
	
	add_child(card)

func set_card_good_or_bad(card):
	var rand = floor(rand_range(0, amtGood+amtBad))
	if rand < amtGood:
		set_card_good(card)
	else:
		set_card_bad(card)

func set_card_good(card):
	amtGood -= 1
	card.add_to_group("is_good_card")
	
	set_card_text(card, sortedGameIdeas["good"])

func set_card_bad(card):
	amtBad -= 1
	card.add_to_group("is_bad_card")
	
	set_card_text(card, sortedGameIdeas["bad"])

func set_card_text(card, textsArray):
	var textsArraySize = textsArray.size()
	var randKey = floor(rand_range(0, textsArraySize))
	var selectedText = textsArray[randKey]
	textsArray.remove(randKey)
	
	card.get_node("IdeaLabel").set_text(selectedText)

func _input(event):
	if focusedCard != null and event is InputEventMouseMotion:
		draggableBody.position += event.relative

func try_lift_card(card):
	if focusedCard == null:
		lift_card(card)

func lift_card(card):
	focusedCard = card

	draggableBody = TouchDragPhysics.instance()
	draggableBody.position = get_viewport().get_mouse_position()
	get_node("/root/Main").add_child(draggableBody)

	var joint = draggableBody.get_node("PinJoint2D")
	joint.set_node_b(card.get_path())

func try_drop_card():
	if focusedCard != null:
		get_node("/root/Main").remove_child(draggableBody)
		draggableBody = null
	
		focusedCard = null