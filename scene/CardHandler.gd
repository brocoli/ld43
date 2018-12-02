extends Node

export (PackedScene) var Card
export (PackedScene) var TouchDragPhysics
export (int) var amountGoodCards
export (int) var amountBadCards
export (float) var radius

var focusedCard
var draggableBody

var amtGood
var amtBad

func _ready():
	seed(OS.get_unix_time())
	spawn_cards()

func spawn_cards():
	amtGood = amountGoodCards
	amtBad = amountBadCards
	
	for i in range(amountGoodCards + amountBadCards):
		spawn_card(i)

func spawn_card(i):
	var distance = rand_range(0, radius)
	var angle = rand_range(0, 2*PI)
	var pos = Vector2(distance*cos(angle), distance*sin(angle))

	var rot = rand_range(0, 2*PI)

	var card = Card.instance()
	card.position = pos
	card.rotation = rot
	card.z_index = i
	
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

func set_card_bad(card):
	amtBad -= 1
	card.add_to_group("is_bad_card")

func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed and focusedCard != null:
		drop_card()

func _input(event):
	if focusedCard != null and event is InputEventMouseMotion:
		draggableBody.position += event.relative


func try_lift_card(bodies):
	if focusedCard == null:
		var card = null
		var max_z = -INF
		
		for body in bodies:
			var new_z = body.z_index
			if max_z < new_z:
				max_z = new_z
				card = body

		if card != null:
			lift_card(card)

func lift_card(card):
	get_tree().set_input_as_handled()
	focusedCard = card

	draggableBody = TouchDragPhysics.instance()
	draggableBody.position = get_viewport().get_mouse_position()
	get_node("/root/Main").add_child(draggableBody)

	var joint = draggableBody.get_node("PinJoint2D")
	joint.set_node_b(card.get_path())

func drop_card():
	get_tree().set_input_as_handled()
	get_node("/root/Main").remove_child(draggableBody)
	draggableBody = null

	focusedCard = null